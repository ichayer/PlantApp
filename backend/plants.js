const PgConnection = require("postgresql-easy");
const { DynamoDBClient } = require("@aws-sdk/client-dynamodb");
const { QueryCommand, DynamoDBDocumentClient } = require("@aws-sdk/lib-dynamodb");

const pg = new PgConnection({
    host: "planty-db-proxy.proxy-cscabcdcjlmn.us-east-1.rds.amazonaws.com",
    port: 5432,
    database: "postgres",
    user: "postgres",
    password: "postgres",
    ssl: true,
});

// https://docs.aws.amazon.com/sdk-for-javascript/v3/developer-guide/javascript_dynamodb_code_examples.html
const dynamoClient = new DynamoDBClient({});
const dynamo = DynamoDBDocumentClient.from(dynamoClient);

async function getPlants(event) {
    let page = Math.max(0, event?.queryStringParameters?.page ?? 0);
    let pageSize = Math.min(Math.max(0, event?.queryStringParameters?.pageSize ?? 10), 100);

    let plantRows = await pg.query("SELECT * FROM plants ORDER BY id DESC LIMIT $1 OFFSET $2", pageSize, page * pageSize);

    let plants = [];
    for (let i = 0; i < plantRows.length; i++) {
        let row = plantRows[i];
        let plantId = row["id"];
        let name = row["name"];
        let description = row["description"];
        let waterFrequencyDays = row["water_frequency_days"];
        let image = row["image"];

        const command = new QueryCommand({
            TableName: "waterings",
            KeyConditionExpression: "plantId = :plantId",
            ExpressionAttributeValues: { ":plantId": plantId },
            ConsistentRead: true,
        });

        let waterings = [];
        const dynamoResponse = await dynamo.send(command);
        dynamoResponse.Items.forEach(ele => waterings.push(ele.timestamp));

        plants.push({
            plantId: plantId,
            name: name,
            description: description,
            waterFrequencyDays: waterFrequencyDays,
            image: image,
            waterings: waterings,
        });
    }

    return {
        statusCode: 200,
        body: JSON.stringify(plants),
    };
}

async function createPlant(event) {
    if (!event.body) return { statusCode: 400, body: "Must specify a request body" };

    let body = JSON.parse(event.body);
    if (!body.name) return { statusCode: 400, body: "Must specify a name in the request body" };
    if (!body.waterFrequencyDays) return { statusCode: 400, body: "Must specify a waterFrequencyDays in the request body" };

    const plantId = await pg.insert("plants", {
        name: body.name,
        description: body.description,
        water_frequency_days: body.waterFrequencyDays
    });

    return {
        statusCode: 200,
        body: JSON.stringify({ plantId: plantId }),
    };
}

async function handler(event) {
    switch (event.requestContext.http.method) {
        case "GET": return await getPlants(event);
        case "POST": return await createPlant(event);
        default: return { statusCode: 405, body: "Method not allowed" };
    }
}

module.exports = {
    handler: handler
}
