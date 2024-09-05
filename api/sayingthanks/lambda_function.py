import json
import boto3
import os
import requests
from requests_toolbelt.multipart.decoder import MultipartDecoder
from requests_toolbelt import MultipartDecoder
s3_client = boto3.client('s3')
client = boto3.client('ses')
def lambda_handler(event, context):
    # TODO implement
    bucket_name = 'your-bucket-name'
    file_name = 'path/to/your/file.txt'
    object_name = "" 
    print("printing all the environment variable", os.environ)
    print(event['headers']['Content-Type'])
    content_type = event['headers']['Content-Type']
    decoder = MultipartDecoder(event['body'].encode(),content_type)
    # print(event['body'].encode())
    
    # print(decoder.parts)
    
    # print(decoder.parts[1].headers.get('Content-Type', 'text/plain'))
    # print(decoder.parts[2].headers.get('Content-Type', 'text/plain'))
    # print(decoder.parts[1].headers)
    # print(decoder.parts[2].headers)
    for part in decoder.parts:
        headers = part.headers
        print(headers)
        content_type = headers.get('Content-Type', 'text/plain')
        print(content_type)
        print(part.text)
        
        if 'application/json' in content_type:
            # Handle JSON part
            print('JSON Data:', part.text)
        elif 'text/plain' in content_type:
            # Handle plain text part
            print('Text Data:', part.text)
        elif 'application/octet-stream' in content_type or 'image/' in content_type:
            # Handle binary data or files
            disposition = headers.get('Content-Disposition', '')
            file_name = disposition.split('filename=')[1].strip('"') if 'filename=' in disposition else 'output.bin'
            object_name = file_name
            with open(file_name, 'wb') as f:
                f.write(part.content)
            print(f'File {file_name} saved.')
        else:
            print('Other Data:', part.content)
    s3_client.upload_file(file_name, bucket_name, object_name)       
    return { 
        'statusCode': 200,
        'body': json.dumps(event['body'])
    }  
         
 