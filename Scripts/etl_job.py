import sys
import subprocess
from urllib.parse import urlparse
# Install typing_extensions if missing
try:
    import typing_extensions
except ImportError:
    subprocess.run([sys.executable, "-m", "pip", "install", "typing_extensions"])

import boto3
import awswrangler as wr
import pandas as pd
from awsglue.utils import getResolvedOptions

# Get Glue Job Arguments
args = getResolvedOptions(sys.argv, ['JOB_NAME'])

# Define S3 Bucket
s3_bucket = "chinokbucket"

# Initialize S3 client
s3_client = boto3.client("s3")

# Get list of all folders in the S3 bucket
def get_folders(bucket):
    """Fetches the folder names inside the S3 bucket."""
    response = s3_client.list_objects_v2(Bucket=bucket, Delimiter="/")
    folders = [content["Prefix"] for content in response.get("CommonPrefixes", [])]
    print("Identified Folders:", folders)  # Print folders to CloudWatch Logs
    return folders

folders = get_folders(s3_bucket)

# Process each folder separately
for folder in folders:
    folder_name = folder.strip("/")  # Remove trailing slash to get folder name
    csv_file_path = f"s3://{s3_bucket}/{folder}{folder_name}.csv"  # Path of CSV file
    try:
        # Read CSV file using AWS Wrangler
        df = wr.s3.read_csv(csv_file_path)
        print(f"Read {csv_file_path} successfully. Shape: {df.shape}")
        wr.s3.to_orc(df=df,path=f's3://chinokbucket/{folder_name}/{folder_name}.orc',index=False)
        
        # Deleting csv file
        parsed_url = urlparse(csv_file_path)
        s3_client.delete_object(Bucket=parsed_url.netloc, Key=parsed_url.path.lstrip("/"))
        print(f"Deleted CSV file: {csv_file_path}")


    except Exception as e:
        print(f"Error processing {csv_file_path}: {str(e)}")

print("All files processed successfully!")
