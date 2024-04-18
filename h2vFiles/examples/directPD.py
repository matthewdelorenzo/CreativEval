import os, sys, itertools
from random import shuffle
from unittest import TestLoader
sys.path.append(os.path.dirname(sys.path[0]))
from hw2vec.config import Config
from hw2vec.hw2graph import *

import pandas as pd
import os
import subprocess

cfg = Config(sys.argv[1:])

csv_file = '/mnt/shared-scratch/Rajendran_J/matthewdelorenzo/codellama/results_lad/flex_gpt35_all.csv'
df = pd.read_csv(csv_file)
test_filepath1 = "/mnt/shared-scratch/Rajendran_J/matthewdelorenzo/codellama/h2vFiles/examples/newfile1"
test_filepath2 = "/mnt/shared-scratch/Rajendran_J/matthewdelorenzo/codellama/h2vFiles/examples/newfile2"

for index, row in df.iterrows():
    #For all tests of using models other than GPT4, uncomment line below.
    #test_sol_text = row['TrimmedModule']  # Assuming 'test_sol' is the column name
    #For GPT4, do not need to trim module (Extracted Text is in modular format already with no prompt text).
    test_sol_text = row['TrimmedModule']  # Assuming 'test_sol' is the column name
    golden_sol_text = row['GoldenSolFull']  # Assuming 'golden_sol' is the column name
    reward_text = row["FixedRewards"]
    module_name = row['Module Name']
    if golden_sol_text == "N/A":
        print("No golden sol for: ", module_name, " index: ", index)
        continue
    elif not test_sol_text:
        print("No Trimmed module for: ", module_name, " index: ", index)
        continue
    # Write to topModule.v
    elif(reward_text == 1):
        with open(os.path.join(test_filepath1, 'topModule.v'), 'w') as top_module_file:
            top_module_file.write(test_sol_text)

        # Write to topModule1.v
        with open(os.path.join(test_filepath2, 'topModule.v'), 'w') as top_module1_file:
            top_module1_file.write(golden_sol_text)

        print(f"Verilog files written for row {index + 1}")

        # removeTop(cfg.test_data_path_1 + "/topModule.v")
        # removeTop(cfg.test_data_path_2 + "/topModule.v")
        print("Preparing data for ", module_name)
        try:
            hw2graph = HW2GRAPH(cfg)

            print("filepath: ", test_filepath1)
            hw_graph1 = hw2graph.code2graph(test_filepath1)
            hw_graph2 = hw2graph.code2graph(test_filepath2)
            data_proc = DataProcessor(cfg)

            data_proc.process(hw_graph1)
            data_proc.process(hw_graph2)
            data_proc.generate_pairs()

            test_pair = data_proc.get_pairs()

            TestLoader = DataLoader(test_pair, shuffle = False, batch_size = 1)

            '''Load the model and the trainer locally'''
            model = GRAPH2VEC(cfg)
            model.load_model(str(cfg.model_path) +"/model.cfg", str(cfg.model_path)+"/model.pth")
            trainer = PairwiseGraphTrainer(cfg)
            trainer.build(model)

            '''Evaluate the similarity using the model'''
            for data in TestLoader:
                #print(data)
                graph1, graph2  = data[0].to(cfg.device), data[1].to(cfg.device)
                g_emb_1, g_emb_2, similarity = trainer.inference_epoch_ip(graph1, graph2)

            print("Similarity " + module_name + ": " + str(similarity.item()) + "\n")
            if abs(similarity.item()) < .6:
                print("Not pirated")
            else:
                print("Pirated")
        except Exception as e:
            # Code to handle any exception (generic exception handling)
            print(f"An error occurred: {e}")



print("Verilog files saved successfully!")


'''Clean up by removing any previously preprocessed files'''
def removeTop(file_path):
    if os.path.exists(file_path):
        with open(os.devnull, 'w') as devnull:
            subprocess.run(["rm", file_path], stdout=devnull, stderr=subprocess.PIPE)
    else:
        print(f"File '{file_path}' does not exist.")




