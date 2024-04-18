import pandas as pd
import os
# Read the CSV file

import os
import pandas as pd
import torch
import torch.nn as nn
import transformers
from transformers import AutoTokenizer, AutoModelForCausalLM, LlamaForCausalLM
import torch
import pandas as pd 
import os
import subprocess

def write_results(prompt, result_text, iteration):
    print("Writing result file: ")
    filepath = "dump_elab/" + iteration + ".v"
    with open(filepath, 'w') as temp_file:
        full_text = result_text
        temp_file.write(full_text)
    return filepath

def compile_code(output_file, result_file, testbench_path):
        proc = subprocess.run(["iverilog", "-o", output_file, "-g2012", result_file, testbench_path],capture_output=True,text=True)
        if proc.returncode != 0:
            print("error compiling testbench: ", testbench_path)
            print("Return code:", proc.returncode)
            print("stderr:", proc.stderr)
        elif proc.stderr != "":
            print("Warnings compiling testbench: ", testbench_path)
            print("stderr:", proc.stderr)
        else:
            print("Successful compilation - running simulation")
        return proc

def simulate_code(output_file):
        try:
            simulation_output = subprocess.check_output(['vvp', output_file], stderr=subprocess.STDOUT)
            simulation_exit_code = 0
        except subprocess.CalledProcessError as e:
            simulation_output = e.output
            simulation_exit_code = e.returncode
        if simulation_exit_code == 0:
            print("Verilog testbench simulation ran successfully.")
            if b"all tests passed" in simulation_output or b"All tests passed" in simulation_output:
                print("Simulation output: ", simulation_output, end='\n\n')
                print("All testbench tests passed!")
                reward = 1
            else:
                print("Some testbench tests failed.")
                print("Simulation output: ", simulation_output,end='\n\n')
                reward = -1
        else: 
            print("Verilog testbench simulation failed.")
            print("Simulation output: ", simulation_output,end='\n\n')
            reward = -1
        return reward

df = pd.read_csv('results_lad/process_gpt4_tmp3.csv')

# # Define the list of prompt names
prompt_names = ['Module_add.v', 'Module_addsub.v', 'Module_cseladd.v', 'Module_fadd.v', 'Module_shift.v', 'Module_shift8.v']

# # Filter rows based on prompt names
filtered_df = df[df['Prompt Name'].isin(prompt_names)]

# # Extract the "Trimmed Module" values
# trimmed_modules = filtered_df['TrimmedModule']


module_dir = "/mnt/shared-scratch/Rajendran_J/matthewdelorenzo/codellama"
pair_dirs = os.listdir("elab_tb")
answers = []
scores = []
for iteration, dir in enumerate(pair_dirs):
    print("-----ITERATION: ", iteration, "-------")
    sample_answers = []
    sample_scores = []	
    filtered_df_for_prompt = filtered_df[filtered_df['Prompt Name'] == dir]
    module_name = os.path.splitext(dir)[0]
    trimmed_modules_for_prompt = filtered_df_for_prompt['TrimmedModule']
    for iteration2, sample in enumerate(trimmed_modules_for_prompt):
        print("-------SAMPLE: ", iteration2, "------")
        print("TEXT:")
        if dir == 'Module_add.v' or dir ==  'Module_addsub.v' or dir ==  'Module_cseladd.v' or dir == "Module_fadd.v":
            sample = '''module add16 ( input[15:0] a, input[15:0] b, input cin, output[15:0] sum, output cout );
        assign sum = a + b;
    endmodule

    ''' + str(sample)
            print("Added adder")
        elif dir == "Module_shift.v":
            sample = '''module my_dff (input clk, input d, output q);
    always @(posedge clk)
        q <= d;
endmodule

''' + str(sample)
            print("Added shift")
        elif dir == "Module_shift8.v":
            sample = '''module my_dff8 ( input clk, input [7:0] d, output [7:0] q );    
    always @(posedge clk)
        q <= d;
endmodule

''' + str(sample)
            print("Added shift8")
        print(sample)
        reward = 1
        result_file = write_results(sample, sample, module_name + "_" + str(iteration) + "_" + str(iteration2))
        testbench_path = module_dir + "/" + "elab_tb/" + str(dir)
        output_file = "dump2_elab/" + module_name + "_compile" + "_" + str(iteration) + "_" + str(iteration2)
        proc = compile_code(output_file, result_file, testbench_path)
        if proc.returncode == 0:
            curr_reward = simulate_code(output_file)
            if(curr_reward == -1):
                reward = -0.5
        else:
            reward = -1
        sample_scores.append(reward)
        #answers.append(generation_trim)
        #scores.append(reward)
        print("Reward = ", reward)
    answers.append(sample_answers)
    scores.append(sample_scores)
        
print("ALL REWARDS: ", scores)
print("ALL ANSWERS: ", answers)
