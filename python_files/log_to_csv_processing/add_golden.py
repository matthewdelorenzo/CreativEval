import os
import pandas as pd

# Read the CSV file (adjust the file path)
csv_file = 'flex_gpt35_all.csv'
df = pd.read_csv(csv_file)

# Directory containing ideal Verilog files (adjust the directory path)
ideal_dir = "/mnt/shared-scratch/Rajendran_J/matthewdelorenzo/codellama/AutoChip-main/hdlbits_solutions_new"

# Create a new column for the extracted text
df['GoldenSolFull'] = ''

# Iterate through each row in the DataFrame
for index, row in df.iterrows():
    verilog_filename = row['Module Name']  # Assuming 'VerilogFileName' is the column name
    ideal_filepath = os.path.join(ideal_dir, verilog_filename)

    # Check if the ideal file exists
    if os.path.exists(ideal_filepath):
        # Read the content from the ideal file
        with open(ideal_filepath, 'r') as ideal_file:
            extracted_text = ideal_file.read()
            df.at[index, 'GoldenSolFull'] = extracted_text
    else:
        print(f"Error: No ideal file found for {verilog_filename}")
        df.at[index, 'GoldenSolFull'] = "N/A"

# Save the updated DataFrame to a new CSV file
df.to_csv(csv_file, index=False)
print(f"Extracted text saved to {csv_file}")