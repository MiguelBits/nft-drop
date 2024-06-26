import pandas as pd
import json
from eth_utils import to_checksum_address

# Load the CSV file
file_path = 'd1_holders_poly.csv'
df = pd.read_csv(file_path)

# Prepare the JSON output
result = {}
current_id = 1  # Starting ID

for index, row in df.iterrows():
    holder_address = to_checksum_address(row['HolderAddress'])
    quantity = row['Quantity']
    
    for _ in range(quantity):
        #if holder_address not in result.values():
        result[str(current_id)] = holder_address
        current_id += 1

# Convert the result to JSON
json_output = json.dumps(result, indent=4)

# Save the JSON output to a file
output_file_path = 'd1_holders_output_POLY.json'
with open(output_file_path, 'w') as json_file:
    json_file.write(json_output)

print(f"JSON output saved to {output_file_path}")
