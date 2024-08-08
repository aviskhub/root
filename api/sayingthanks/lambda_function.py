import json
import boto3

client = boto3.client('ses')
def lambda_handler(event, context):
    # TODO implement
    print("printing all the environment variable", os.environ)
   
    return { 
        'statusCode': 200,
        'body': json.dumps()
    }  
         
 