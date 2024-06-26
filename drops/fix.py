import pandas as pd
from eth_utils import to_checksum_address
import json

# Load the CSV file
file_path = 'd1_holders_eth.csv'
df = pd.read_csv(file_path)

# Prepare the JSON output
result = {}
current_id = 1  # Starting ID

for index, row in df.iterrows():
    holder_address = to_checksum_address(row['HolderAddress'])
    quantity = row['Quantity']
    
    result[str(current_id)] = {
        "address": holder_address,
        "quantity": quantity
    }
    current_id += 1

# Convert the result to JSON
json_output = json.dumps(result, indent=4)

# Save the JSON output to a file
output_file_path = 'FIX_d1_holders_output_ETH.json'
with open(output_file_path, 'w') as json_file:
    json_file.write(json_output)

print(f"JSON output saved to {output_file_path}")
