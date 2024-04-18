
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
import openai
from openai import OpenAI
#Sey your OPENAI_API_KEY to your OpenAI API secret key.

def subtract_prompt(row):
    return row['Generation'][len(row['Prompt']):]

def remove_prompt_from_output(prompt, output):
    # Ensure the output starts with the prompt
    if output.startswith(prompt):
        print("Trimmed output: ", output[len(prompt):])
        return output[len(prompt):]
    else:
        print("Error: The output does not start with the prompt.")
        print("Output: ", output)
        return output

def list_directories(path):
    print("Listing directories: ")
    return [d for d in os.listdir(path) if os.path.isdir(os.path.join(path, d))]



def write_results(prompt, result_text, iteration, sample, module_name):
    print("Writing result file: ")
    filepath = "gpt4_dump/prompt_tmp7/" + iteration +"_" + sample + "_" + module_name + ".v"
    with open(filepath, 'w') as temp_file:
        full_text = result_text
        temp_file.write(full_text)
    return filepath

def read_prompt(prompt_file):
        print("Reading prompt")
        output_prompt = ""
        if prompt_file.endswith(".v"):
                with open(prompt_file, 'r') as file:
                    output_prompt = file.read()
        else:
            print(prompt_file)
            print("Error reading the prompt")
            return 0
        return output_prompt


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


def chat_with_chatgpt(prompt, model="gpt-4-turbo-preview"):
    client = OpenAI(api_key=OPENAI_API_KEY)
    response = client.chat.completions.create(
        model=model,
        messages=[
            {"role": "user", "content": prompt}
            ],
            max_tokens=1024,
            n=1,
            stop=None,
            temperature=0.7,
        )
    text = response.choices[0].message.content
    print("Message: ", text)
    start_token = "```verilog"
    start_token_index = text.find(start_token)
    if start_token_index != -1:
        print("Trimming prompt: ")
        text = text[start_token_index + len(start_token):]
        
    end_token_index = text.find("endmodule")
    if end_token_index != -1:
        print("Cutting off at first endmodule: ")
        text = text[:end_token_index] + "endmodule"
    print("Trimmed text: ")
    print(text)
    return text


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


module_dir = "/mnt/shared-scratch/Rajendran_J/matthewdelorenzo/rltf/AutoChip/pairs"
pair_dirs = list_directories(module_dir)
answers = []
scores = []
for iteration, dir in enumerate(pair_dirs):
    print("-----ITERATION: ", iteration, "-------")
    for sample in range(10):
        sample_answers = []
        sample_scores = []	
        print("-------SAMPLE: ", sample, "------")
        prompt_testbench_array = sorted(os.listdir(module_dir + "/" + str(dir)))
        prompt_file = prompt_testbench_array[0]
        testbenches = prompt_testbench_array[1:]
        reward = 1
        prompt_text = read_prompt(module_dir + "/" + str(dir) + "/" + prompt_file)
        module_name = os.path.splitext(prompt_file)[0]
        generation = chat_with_chatgpt(prompt_text)
        result_file = write_results(prompt_text, generation, str(iteration), str(sample), module_name)
        for i, testbench in enumerate(testbenches):
            testbench_path = module_dir + "/" + str(dir) + "/" + testbench
            output_file = "gpt4_dump2/prompt_tmp7/" + module_name + "_compile" + "_" + str(sample)
            proc = compile_code(output_file, result_file, testbench_path)
            if proc.returncode == 0:
                curr_reward = simulate_code(output_file)
                if(curr_reward == -1):
                    reward = -0.5
            else:
                reward = -1

        sample_answers.append(prompt_text) 
        sample_scores.append(reward)
        print("Reward = ", reward)
    answers.append(sample_answers)
    scores.append(sample_scores)
        
print("ALL REWARDS: ", scores)
print("ALL ANSWERS: ", answers)
