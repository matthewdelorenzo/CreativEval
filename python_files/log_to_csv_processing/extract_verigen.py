
import re
import csv


import re
import csv

# def extract_text_and_reward(log_file_path, output_csv_path):
#     # Read the log file
#     with open(log_file_path, 'r') as file:
#         log_content = file.read()

#     # Define the updated regular expression pattern
#     pattern = r"Trimmed output:(.*?)(Reward =  [-+]?\d*\.?\d+)"

#     # Find all matches in the log content
#     matches = re.findall(pattern, log_content, re.DOTALL)

#     # Write the extracted text and reward value to a CSV file
#     with open(output_csv_path, 'w', newline='') as csvfile:
#         writer = csv.writer(csvfile)
#         writer.writerow(['Extracted Text', 'Reward'])  # Write header
#         for match in matches:
#             writer.writerow([match[0].strip(), match[1]])

# # Example usage
# log_file_path = 'lad_llama13b_10iter.log'
# csv_path = "process_lad_llama13b_10iter.csv"
# extract_text_and_reward(log_file_path, csv_path)


# #VERIGEN EXTRACT
# def extract_text_and_reward(log_file_path, output_csv_path):
#     # Read the log file
#     with open(log_file_path, 'r') as file:
#         log_content = file.read()

#     # Define the updated regular expression pattern
#     #pattern = r"(Generated text|Output): (.*?)(Reward =|Writing result file:)" 
#     pattern = r"Generated text: (.*?)Writing result file: "
#     # Find all matches in the log content
#     matches = re.findall(pattern, log_content, re.DOTALL)

#     with open(output_csv_path, 'w', newline='') as csvfile:
#         writer = csv.writer(csvfile)
#         writer.writerow(['Extracted Text'])  # Write header
#         for match in matches:
#             writer.writerow([match.strip()])

# # Example usage
# log_file_path = 'lad_verigen6b_10iter.log'
# csv_path = "lad_verigen6b_10iter_0_new.csv"
# extract_text_and_reward(log_file_path, csv_path)


def read_prompt(prompt_file):
        #print("Reading prompt")
        output_prompt = ""
        if prompt_file.endswith(".v"):
                with open(prompt_file, 'r') as file:
                    output_prompt = file.read()
        else:
            #print(prompt_file)
            print("Error reading the prompt")
            return 0
        return output_prompt


#VERIGEN EXTRACT - NE
import re

def extract_text_and_reward(log_file_path):
    # Read the log file
    with open(log_file_path, 'r') as file:
        log_content = file.read()

    # Define the regular expression pattern
    pattern = r"Generated text: \n(.*?)Writing result file:.*?Reward =  ([\d.-]+)"

    #pattern = r"Trimmed text: \n(.*?)Writing result file:.*?Reward =  ([\d.-]+)"
    #pattern = r"Module: ([^\n]+)\s+Generated text: \n(.*?)Writing result file:.*?Reward = ([\d.-]+)"
    pattern2 = r" Module: ([^\n]+)"
    # Find all matches in the log content
    matches = re.findall(pattern, log_content, re.DOTALL)
    matches2 = re.findall(pattern2, log_content, re.DOTALL)
    # Extract the captured values
    extracted_texts, rewards = zip(*matches)
    module_names = list(matches2)
    #module_names = [module_name for module_name in module_names for _ in range(10)]
    # Assign to separate variables
    extracted_text_variable = list(extracted_texts)
    reward_variable = list(rewards)
    extracted_text_variable = [text.strip() for text in extracted_text_variable]
    prompt_texts = []
    prompt_dir = "/mnt/shared-scratch/Rajendran_J/matthewdelorenzo/codellama/AutoChip-main/flexibility_prompts/"
    for module_name in module_names:
        prompt_text = read_prompt(prompt_dir + "/" + str(module_name))
        prompt_texts.append(prompt_text)
    return extracted_text_variable, reward_variable, module_names, prompt_texts

def write_to_csv(csv_path, extracted_texts, rewards, module_names, prompt_texts):
    with open(csv_path, 'w', newline='') as csvfile:
        writer = csv.writer(csvfile)
        writer.writerow(['Extracted Text', 'Reward', 'Module Name', 'Prompt Texts'])  # Write header
        for text, reward, name, prompt in zip(extracted_texts, rewards, module_names, prompt_texts):
            writer.writerow([text, reward, name, prompt])


# Example usage
log_file_path = "/mnt/shared-scratch/Rajendran_J/matthewdelorenzo/codellama/results_lad/flex_tmp3/flex_gpt35_tmp3_0.log"
extracted_texts, rewards, modules, prompt_texts= extract_text_and_reward(log_file_path)

print(len(modules))
print(len(extracted_texts))
# Now you can use the extracted_texts and rewards variables as needed
#print("Extracted Texts:", extracted_texts)
#print("Rewards:", rewards)


csv_path = "flex_gpt35_tmp3.csv"
write_to_csv(csv_path, extracted_texts, rewards, modules, prompt_texts)
#print(f"Data written to {csv_path}")