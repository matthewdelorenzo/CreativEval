import os, sys, itertools
from random import shuffle
from unittest import TestLoader
sys.path.append(os.path.dirname(sys.path[0]))
from hw2vec.config import Config
from hw2vec.hw2graph import *

import os
import subprocess

cfg = Config(sys.argv[1:])

'''Clean up by removing any previously preprocessed files'''
def removeTop(file_path):
    if os.path.exists(file_path):
        with open(os.devnull, 'w') as devnull:
            subprocess.run(["rm", file_path], stdout=devnull, stderr=subprocess.PIPE)
    else:
        print(f"File '{file_path}' does not exist.")

removeTop(cfg.test_data_path_1 + "/topModule.v")

''' prepare target data'''
hw2graph = HW2GRAPH(cfg)

hw_graph1 = hw2graph.code2graph(cfg.test_data_path_1)
target_proc = DataProcessor(cfg)
target_proc.process(hw_graph1)

''' Get bulk data'''
data_proc = DataProcessor(cfg)
data_proc.read_graph_data_from_cache(cfg.data_pkl_path)

''' Generate testing pairs '''
data_proc.generate_target_pairs(target_proc.get_graphs()[0])
test_pairs = data_proc.get_pairs()
TestLoader = DataLoader(test_pairs, shuffle = False, batch_size = 1)

'''Load the model and the trainer locally'''
model = GRAPH2VEC(cfg)
model.load_model(str("model.cfg"), str("model.pth"))
trainer = PairwiseGraphTrainer(cfg)
trainer.build(model)

'''Evaluate the similarity using the model'''
maxSimilarity = 0
matchCircuit = ""
for data in TestLoader:
    #print(data)
    graph1, graph2  = data[0].to(cfg.device), data[1].to(cfg.device)
    g_emb_1, g_emb_2, similarity = trainer.inference_epoch_ip(graph1, graph2)
    if maxSimilarity < similarity.item():
        maxSimilarity = similarity.item() 

print("Similarity: " + str(maxSimilarity) + "\n")
if abs(maxSimilarity) < .8:
    print("Not pirated")
else:
    print("Pirated")
print("\n")

