import json
import boto3

def _send_to_connection(endpoint_url, connection_id, data):
    gatewayapi = boto3.client("apigatewaymanagementapi", endpoint_url = endpoint_url)
    return gatewayapi.post_to_connection(Data=data.encode('utf-8'), ConnectionId=connection_id)

def lambda_handler(event, context):
    if event is not None and 'requestContext' in event.keys():
        if event['requestContext']['routeKey'] == '$connect':
            print('$connect')
        elif event['requestContext']['routeKey'] == '$disconnect':
            print('$disconnect')
        elif event['requestContext']['routeKey'] == 'onMessage':
            endpoint_url = "https://" + event['requestContext']['domainName'] + '/' + event['requestContext']['stage']
            connectionId = event['requestContext']['connectionId']
            print("routeKey: {}, endpoint_url: {}, coonectionId: {}".format('onMessage', endpoint_url, connectionId))
            data = "messageId: {0}, routeKey: {1}, sourceIp: {2}".format(
                event['requestContext']['messageId'],
                event['requestContext']['routeKey'],
                event['requestContext']['identity']['sourceIp'])
            _send_to_connection(endpoint_url, connectionId, data)
        else:
            print('$default')

        return {
            'statusCode': 200,
            'body': json.dumps('')
        }

