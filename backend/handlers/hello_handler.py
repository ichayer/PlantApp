import json
from internal.utils import some_string


def hello(event, context):
    body = {
        "message": "Go Serverless v4.0! Your function executed successfully!",
        "pd": some_string()
    }

    response = {"statusCode": 200, "body": json.dumps(body)}

    return response
