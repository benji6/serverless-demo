import boto3
from boto3.dynamodb.conditions import Key

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('comments_demo')

def handler(event, context):
  response = table.query(KeyConditionExpression=Key('userId').eq('test-user'))
  return sorted(response['Items'], key=lambda x: x['dateCreated'], reverse=True)
