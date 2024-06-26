import pandas as pd
from eth_utils import to_checksum_address

def convert_to_checksum(addresses):
    checksummed_addresses = []
    for address in addresses:
        checksummed_address = to_checksum_address(address)
        checksummed_addresses.append(checksummed_address)
    return checksummed_addresses

def write_addresses_to_files(addresses, base_filename, addresses_per_file=100):
    total_addresses = len(addresses)
    num_files = (total_addresses // addresses_per_file) + (1 if total_addresses % addresses_per_file != 0 else 0)

    for i in range(num_files):
        start_index = i * addresses_per_file
        end_index = min(start_index + addresses_per_file, total_addresses)
        filename = f"{base_filename}_{i+1}.txt"

        with open(filename, 'w') as file:
            for address in addresses[start_index:end_index]:
                file.write(address + ',\n')

# Example usage
if __name__ == "__main__":
    # Load the unique addresses from the CSV file
    file_path = 'unique_tokenholders.csv'
    data = pd.read_csv(file_path)

    # Extract the HolderAddress column
    addresses = data['HolderAddress'].tolist()

    # Convert to checksummed addresses
    checksummed_addresses = convert_to_checksum(addresses)

    # Write the checksummed addresses to files
    write_addresses_to_files(checksummed_addresses, 'checksummed_tokenholders', 100)

    print("Addresses have been written to files.")
