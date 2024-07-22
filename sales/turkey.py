import pandas as pd
from eth_utils import to_checksum_address
import json

# List of CSV file paths
csv_files = ['turkey_289.csv']
output_file_path = 'turkey_289.json'

# Dictionary to store the cumulative quantity for each address
address_quantity = {}

# Process each CSV file
for file_path in csv_files:
    df = pd.read_csv(file_path)
    for index, row in df.iterrows():
        holder_address = row['Paste your wallet address below']
        print(holder_address);
        if(holder_address[0] == '0' and holder_address[1] == 'x' and '...' not in holder_address):
            address_quantity[to_checksum_address(holder_address)] = 1
        else:
            continue

# Prepare the JSON output
result = {}
current_id = 1  # Starting ID

for address, quantity in address_quantity.items():
    result[str(current_id)] = {
        "address": address,
        "quantity": 1
    }
    current_id += 1

# Convert the result to JSON
json_output = json.dumps(result, indent=4)

# Save the JSON output to a file
with open(output_file_path, 'w') as json_file:
    json_file.write(json_output)

print(f"JSON output saved to {output_file_path}")
