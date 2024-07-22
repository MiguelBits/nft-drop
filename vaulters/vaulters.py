import pandas as pd
from eth_utils import to_checksum_address, to_wei
import json

# List of CSV file paths
csv_files = ['bsc_sdao.csv'] #TODO
output_file_path = 'bsc_sdao.json' #TODO
contract = '0xd8912300c2b96d9f2fb8f4a9cfea351ebe2a696e' #TODO

# Dictionary to store the cumulative quantity for each address
address_quantity = {}

# Process each CSV file
for file_path in csv_files:
    df = pd.read_csv(file_path)
    
    # Ensure TokenValue is treated as numeric, replacing commas and converting to float
    df['TokenValue'] = df['TokenValue'].str.replace(',', '').astype(float)

    for index, row in df.iterrows():
        #print(row['From'], row['To'], row['TokenValue'])
        
        quantity_wei = to_wei(row['TokenValue'], 'ether')
        
        if row['From'] != contract:
            holder_address = to_checksum_address(row['From'])
            if holder_address in address_quantity:
                address_quantity[holder_address] += quantity_wei
            else:
                address_quantity[holder_address] = quantity_wei
        else:
            holder_address = to_checksum_address(row['To'])
            if holder_address in address_quantity:
                address_quantity[holder_address] -= quantity_wei
            else:
                address_quantity[holder_address] = -quantity_wei

        # Ensure quantity does not go below 0
        if address_quantity[holder_address] < 0:
            address_quantity[holder_address] = 0

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
with open(output_file_path, 'w') as json_file:
    json_file.write(json_output)

print(f"JSON output saved to {output_file_path}")
