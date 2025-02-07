import logging

# Set up logging
logger = logging.getLogger()
logger.setLevel(logging.INFO)

# Initialize AWS clients
s3 = boto3.client('s3')
glue = boto3.client('glue')

def lambda_handler(event, context):
    logger.info(f"Received event: {json.dumps(event, indent=2)}")  # Log event

    bucket_name = "chinokbucket"
    
    expected_files = {
        "Album/Album.csv", "Aritst/Artist.csv", "Customer/Customer.csv",
        "Employee/Employee.csv", "Genre/Genre.csv", "Invoice/Invoice.csv",
        "InvoiceLine/InvoiceLine.csv", "MediaType/MediaType.csv",
        "Playlist/Playlist.csv", "PlaylistTrack/PlaylistTrack.csv",
        "Track/Track.csv"
    }  # Add all required files here

    try:
        # Extract bucket and file name from S3 event
        for record in event.get('Records', []):
            event_bucket = record['s3']['bucket']['name']
            event_file = record['s3']['object']['key']

            logger.info(f"Triggered by file: {event_file} in bucket: {event_bucket}")

        # List objects in the S3 bucket
        response = s3.list_objects_v2(Bucket=bucket_name)
        
        # Extract file names from the response
        files_in_s3 = {obj['Key'] for obj in response.get('Contents', [])}
        
        logger.info(f"Files found in S3: {files_in_s3}")

        # Check if all required files are present
        if expected_files.issubset(files_in_s3):
            logger.info("All required files are present. Triggering Glue Job.")
            
            # Trigger AWS Glue ETL job
            glue_response = glue.start_job_run(JobName="S3")
            
            logger.info(f"Glue job triggered successfully: {glue_response}")
            
            return {"status": "Glue Job Triggered", "glue_job_id": glue_response["JobRunId"]}

        logger.info("Not all required files are present. Waiting...")
        return {"status": "Waiting for all files", "missing_files": list(expected_files - files_in_s3)}

    except Exception as e:
        logger.error(f"An error occurred: {str(e)}", exc_info=True)
        return {"status": "Error", "message": str(e)}
