import pandas as pd
from eth_utils import to_checksum_address
import json

# List of CSV file paths
csv_files = ['d2_holders_eth.csv',
    'd3_holders_eth.csv',
    'd4_holders_eth.csv',
    'd5_holders_eth.csv']

# Dictionary to store the cumulative quantity for each address
address_quantity = {}

# Process each CSV file
for file_path in csv_files:
    df = pd.read_csv(file_path)
    for index, row in df.iterrows():
        holder_address = to_checksum_address(row['HolderAddress'])
        quantity = row['Quantity']
        
        if holder_address in address_quantity:
            address_quantity[holder_address] += quantity
        else:
            address_quantity[holder_address] = quantity

# Prepare the JSON output
result = {}
current_id = 1  # Starting ID

for address, quantity in address_quantity.items():
    result[str(current_id)] = {
        "address": address,
        "quantity": quantity
    }
    current_id += 1

# Convert the result to JSON
json_output = json.dumps(result, indent=4)

# Save the JSON output to a file
output_file_path = 'coremodule_holders_output_combined.json'
with open(output_file_path, 'w') as json_file:
    json_file.write(json_output)

print(f"JSON output saved to {output_file_path}")
