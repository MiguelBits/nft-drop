import pandas as pd

# Load the CSV files
bsc_holders = pd.read_csv('bsc_holders.csv')
eth_holders = pd.read_csv('eth_holders.csv')

# Merge both CSV files into one dataframe without repeating any addresses
combined_holders = pd.concat([bsc_holders, eth_holders]).drop_duplicates(subset=['HolderAddress'])

# Save the combined unique addresses to a new CSV file
combined_holders.to_csv('combined_holders_unique.csv', index=False)

print("The combined CSV file with unique addresses has been created successfully.")
