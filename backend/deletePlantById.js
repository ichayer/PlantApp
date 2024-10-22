const PgConnection = require("postgresql-easy");

const pg = new PgConnection({
    host: process.env.DB_HOST,
    port: 5432,
    database: "postgres",
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    ssl: true,
});

async function deletePlantById(event) {
    let plantId = Number(event.pathParameters.plantId);
    let result = pg.deleteById("plants", plantId);

    return {
        statusCode: 200,
        body: JSON.stringify(result)
    };
}

module.exports = {
    deletePlantById: deletePlantById,
}
