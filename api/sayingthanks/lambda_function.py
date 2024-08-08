import json
import boto3
import os
import requests
client = boto3.client('ses')
def lambda_handler(event, context):
    # TODO implement
    print("printing all the environment variable", os.environ)
    r = requests.get('https://api.github.com')
    return { 
        'statusCode': 200,
        'body': json.dumps(event)
    }  
         
 