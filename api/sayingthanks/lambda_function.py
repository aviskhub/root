import json
import boto3
s3 = boto3.client('s3')
def lambda_handler(event, context):
    # TODO implement
    bucket =  s3.list_bucket()
    return { 
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda!')
    }  
         