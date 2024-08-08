import json
import boto3
import os


client = boto3.client('ses')
def lambda_handler(event, context):
    # TODO implement
    print("printing all the environment variable", os.environ)
    print("printing the current directory", os.getcwd())
    print("printing the user", os.getlogin())
    # print("testing",event['path'])
    # print("resource:",event['resource'])
    # print(event)
    # response= client.send_email(
    #     Source = "abhishekdropbox01@gmail.com",
    #     Destination={
    #         'ToAddresses':["cloudavi01@gmail.com"]      
    #     },
    #     Message={
    #         'Subject': {
    #             'Data': 'subject of the email'
    #         } ,
    #         'Body': {
    #             'Html':{
    #                 'Data': 'Hello from abhishek'
    #             }
    #         }
    #     }
    #     )
    # response = client.list_buckets()
    # print(type(response))
    # print(response)
    # print(event)
    # print("this is of type", type(event))
    return { 
        'statusCode': 200,
        'body': json.dumps(event)
    }  
         
