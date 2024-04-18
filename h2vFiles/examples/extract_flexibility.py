def read_verilog_data(filename):
    """
    Read the text file and extract Verilog filenames and similarity values.
    Returns a dictionary with filenames as keys and similarity values as values.
    """
    verilog_data = {}
    with open(filename, 'r') as file:
        lines = file.readlines()
        for line in lines:
            if line.startswith("Similarity"):
                parts = line.split(": ")
                filename = parts[0].split(" ")[-1]
                similarity = float(parts[1])
                if filename not in verilog_data:
                    verilog_data[filename] = []  # Initialize an empty list for each filename
                verilog_data[filename].append(similarity)  # Append the similarity value
    return verilog_data

def count_unique_creativity_values(verilog_data):
    unique_values_per_filename = {}
    
    for filename, values in verilog_data.items():
        unique_values = set(values)  # Create a set to store unique values
        unique_values_per_filename[filename] = len(unique_values)
    
    return unique_values_per_filename

def count_low_similarity_files(verilog_data):
    count = 0
    for filename, similarities in verilog_data.items():
        for similarity in similarities:
            if similarity < 0.5:
                count += 1
                break  # No need to check other similarities for this filename
    return count

def calculate_average_minimum_similarity(verilog_data):
    # Calculate minimum similarity values
    min_similarity_values = {filename: min(values) for filename, values in verilog_data.items()}

    # Calculate average minimum similarity
    average_min_similarity = sum(min_similarity_values.values()) / len(min_similarity_values)

    return average_min_similarity, min_similarity_values

def calculate_average_unique_instances(unique_values_per_filename):
    total_unique_instances = sum(unique_values_per_filename.values())
    num_filenames = len(unique_values_per_filename)
    
    average_unique_instances = total_unique_instances / num_filenames
    
    return average_unique_instances

if __name__ == "__main__":
    filename = "flex_got35_originality_greedy.log"  # Replace with the actual filename
    verilog_data = read_verilog_data(filename)

    # Calculate minimum similarity values

    # Calculate average minimum similarity

    count = count_low_similarity_files(verilog_data)
    print ("Low similarity files: ", count)
    print ("Total: ", len(verilog_data))