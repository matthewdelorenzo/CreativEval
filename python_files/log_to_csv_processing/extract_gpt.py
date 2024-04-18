
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





#VERIGEN EXTRACT - NEW
import re

def extract_text_and_reward(log_file_path):
    # Read the log file
    with open(log_file_path, 'r') as file:
        log_content = file.read()

    # Define the regular expression pattern
    pattern = r"Trimmed text: \n(.*?)Writing result file:.*?Reward =  ([\d.-]+)"
    # Find all matches in the log content
    matches = re.findall(pattern, log_content, re.DOTALL | re.MULTILINE)

    # Extract the captured values
    extracted_texts, rewards = zip(*matches)

    # Assign to separate variables
    extracted_text_variable = list(extracted_texts)
    reward_variable = list(rewards)
    extracted_text_variable = [text.strip() for text in extracted_text_variable]
    return extracted_text_variable, reward_variable

def write_to_csv(csv_path, extracted_texts, rewards):
    with open(csv_path, 'w', newline='') as csvfile:
        writer = csv.writer(csvfile)
        writer.writerow(['Extracted Text', 'Reward'])  # Write header
        for text, reward in zip(extracted_texts, rewards):
            writer.writerow([text, reward])

# Example usage
log_file_path = 'lad_gpt4_tmp3_111after.log'
extracted_texts, rewards = extract_text_and_reward(log_file_path)

# Now you can use the extracted_texts and rewards variables as needed
print("Extracted Texts:", extracted_texts)
print("Rewards:", rewards)


csv_path = "process_gpt4_tmp3_3.csv"
write_to_csv(csv_path, extracted_texts, rewards)
print(f"Data written to {csv_path}")