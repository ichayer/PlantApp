const PgConnection = require("postgresql-easy");
const { DynamoDB } = require('@aws-sdk/client-dynamodb');
const { DynamoDBDocument } = require('@aws-sdk/lib-dynamodb');

const dynamo = DynamoDBDocument.from(new DynamoDB());

const pg = new PgConnection({
  host: "planty-db-proxy.proxy-cscabcdcjlmn.us-east-1.rds.amazonaws.com",
  port: 5432,
  database: "postgres",
  user: "postgres",
  password: "postgres",
  ssl: true,
});

async function getPlants(event) {
  let page = Math.max(0, event?.queryStringParameters?.page ?? 0);
  let pageSize = Math.min(Math.max(0, event?.queryStringParameters?.pageSize ?? 10), 100);

  let plantRows = await pg.query("SELECT * FROM plants LIMIT $1 OFFSET $2", pageSize, page * pageSize);
  
  let plants = [];
  for (let i = 0; i < plantRows.length; i++) {
    let row = plantRows[i];
    let plantId = row["id"];
    let name = row["name"];
    let waterFrequencyDays = row["water_frequency_days"];
    let image = row["image"];

    // https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/example_dynamodb_Query_section.html
    let dynamoResponse = await dynamo.scan({ TableName: "waterings" });

    plants.push({
      plantId: plantId,
      name: name,
      waterFrequencyDays: waterFrequencyDays,
      image: image,
      waterings: dynamoResponse.Items,
    });
  }

  const response = {
    statusCode: 200,
    body: JSON.stringify({
      hello: "Hello from Lambda!",
      fact: plants,
      event: event,
    }),
  };

  return response;
}

async function createPlant(event) {
  throw new Error('Not implemented 🤠');
}

async function plantsHandler(event) {
  switch (event.requestContext.http.method) {
    case "GET": return await getPlants(event);
    case "POST": return await createPlant(event);
    default: throw new Error(`Unsupported method "${event.requestContext.http.method}"`);
  }
}

module.exports = {
  plants: plantsHandler
}
