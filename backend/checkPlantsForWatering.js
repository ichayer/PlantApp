const PgConnection = require("postgresql-easy");
const { SQSClient, SendMessageCommand } = require("@aws-sdk/client-sqs");
const { DynamoDBClient, QueryCommand, DynamoDBDocumentClient } = require("@aws-sdk/lib-dynamodb");

const sqs = new SQSClient({});
const dynamoClient = new DynamoDBClient({});
const dynamo = DynamoDBDocumentClient.from(dynamoClient);

const pg = new PgConnection({
    host: process.env.DB_HOST,
    port: 5432,
    database: "postgres",
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    ssl: true,
});

async function getLastWatering(plantId) {
    const command = new QueryCommand({
        TableName: "waterings",
        KeyConditionExpression: "plantId = :plantId",
        ExpressionAttributeValues: { ":plantId": plantId },
        ConsistentRead: true,
        Limit: 1,
        ScanIndexForward: false,
    });

    const response = await dynamo.send(command);
    return response.Items[0]?.timestamp;
}

async function checkPlantsForWatering() {
    const plants = await pg.query("SELECT id, name, water_frequency_days, uuid FROM plants");

    const today = new Date();
    const notifications = [];

    for (const plant of plants) {
        const lastWateringDate = await getLastWatering(plant.id);

        if (!lastWateringDate) {
            notifications.push({
                type: 'TODAY',
                plantId: plant.id,
                plantName: plant.name,
                uuid: plant.uuid,
                waterFrequencyDays: plant.water_frequency_days,
                lastWatering: "N/A",
            });
            continue;
        }

        const lastWatering = new Date(lastWateringDate);
        const nextWatering = new Date(lastWatering);
        nextWatering.setDate(nextWatering.getDate() + plant.water_frequency_days);

        if (today.toDateString() === nextWatering.toDateString()) {
            notifications.push({
                type: 'TODAY',
                plantId: plant.id,
                plantName: plant.name,
                uuid: plant.uuid,
                waterFrequencyDays: plant.water_frequency_days,
                lastWatering: lastWateringDate,
            });
        }
    }

    for (const plant of notifications) {
        const message = {
            type: 'TODAY',
            plantId: plant.id,
            plantName: plant.name,
            uuid: plant.uuid,
            waterFrequencyDays: plant.water_frequency_days,
            lastWatering: plant.lastWatering,
        };

        const command = new SendMessageCommand({
            QueueUrl: process.env.SQS_QUEUE_URL,
            MessageBody: JSON.stringify(message),
            MessageAttributes: {
                notificationType: {
                    DataType: 'String',
                    StringValue: 'TODAY',
                },
            },
        });

        await sqs.send(command);
    }

    return {
        statusCode: 200,
        body: JSON.stringify(notifications ),
    };
}

module.exports = { 
    checkPlantsForWatering: checkPlantsForWatering, 
};
