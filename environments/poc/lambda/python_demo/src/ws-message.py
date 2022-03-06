import json
import boto3

def lambda_handler(event, context):
    # TODO implement
    print(event)

    if event is not None and 'requestContext' in event.keys():
        endpoint_url = "https://" + event['requestContext']['domainName'] + '/' + event['requestContext']['stage']
        connectionId = event['requestContext']['connectionId']
        print(endpoint_url)
        print(connectionId)
        _send_to_connection(endpoint_url, connectionId, event['requestContext']['messageId'])

    return {
        'statusCode': 200,
        'body': json.dumps('')
    }

def _send_to_connection(endpoint_url, connection_id, data):
    gatewayapi = boto3.client("apigatewaymanagementapi", endpoint_url)
    return gatewayapi.post_to_connection(Data=data.encode('utf-8'), ConnectionId=connection_id)
