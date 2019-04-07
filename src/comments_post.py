import boto3
from boto3.dynamodb.conditions import Key
from datetime import datetime

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('comments_demo')

def handler(event, context):
  item = {
    'body': event['body'],
    'dateCreated': datetime.now().isoformat(),
    'userId': 'test-user',
  }
  table.put_item(Item=item)
  return item
