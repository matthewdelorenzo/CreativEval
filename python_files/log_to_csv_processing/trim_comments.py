import pandas as pd

# Read the CSV file into a DataFrame
csv_name = "flex_gpt35_all.csv"
df = pd.read_csv(csv_name)

df['TrimmedModule'] = ''

for index, row in df.iterrows():
    
    whole_module_text = row['WholeModule']
    start_index = whole_module_text.find("module top_module (")
    if start_index == -1:
        start_index = whole_module_text.find("module top_module(")
    if start_index != -1:
        trimmed_text = whole_module_text[start_index:]
        df.at[index, 'TrimmedModule'] = trimmed_text
        print("Good, index:", index)
    else:
        print("bad")
        print(index)
        print(whole_module_text)


df.to_csv(csv_name, index=False)