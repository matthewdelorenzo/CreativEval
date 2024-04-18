import pandas as pd
import os
def list_directories(path):
    print("Listing directories: ")
    return [d for d in os.listdir(path) if os.path.isdir(os.path.join(path, d))]


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


module_dir = "/mnt/shared-scratch/Rajendran_J/matthewdelorenzo/rltf/AutoChip/pairs"
#module_dir = "/mnt/shared-scratch/Rajendran_J/matthewdelorenzo/codellama/test"
pair_dirs = list_directories(module_dir)
prompt_names = []
prompt_data = []
for iteration, dir in enumerate(pair_dirs):
    for sample in range(10):
        prompt_testbench_array = sorted(os.listdir(module_dir + "/" + str(dir)))
        prompt_file = prompt_testbench_array[0]
        #if(prompt_file != "Fsm_serialdp.v"):
        prompt_text = read_prompt(module_dir + "/" + str(dir) + "/" + prompt_file)
        prompt_data.append(prompt_text)
        prompt_names.append(prompt_file)
        testbenches = prompt_testbench_array[1:]

existing_csv_path = 'process_gpt4_tmp3.csv'
existing_df = pd.read_csv(existing_csv_path)

# Add the prompts list as a new column
existing_df['Prompt Name'] = prompt_names
existing_df['Prompt Text'] = prompt_data
# Write the updated DataFrame back to the same CSV file
existing_df.to_csv(existing_csv_path, index=False)

print(f"Prompt texts written to the second column of {existing_csv_path}.")