import pandas as pd

# Read the CSV file into a DataFrame
csv_name = 'flex_gpt35_all.csv'
df = pd.read_csv(csv_name)

# Replace empty strings with NaN
df.replace('', float('nan'), inplace=True)

# Create a new column by combining the second and third columns
#df['WholeModule'] = df['Prompt Text'].fillna('') + df['Extracted Text'].fillna('')
df['WholeModule'] = df['Prompt Texts'].fillna('') + "\n" + df['Extracted Text'].fillna('')

df.replace('', float('nan'), inplace=True)

# Identify empty rows in the WholeModule column
empty_rows = df[pd.isnull(df['WholeModule'])]
if len(empty_rows) > 0:
    print("Empty rows...")
# Replace empty WholeModule values with Prompt Text values
    df.loc[empty_rows.index, 'WholeModule'] = empty_rows['Prompt Text']

# Save the updated DataFrame to a new CSV file
df.to_csv(csv_name, index=False)