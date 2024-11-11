const { SNSClient, PublishCommand } = require("@aws-sdk/client-sns");

const sns = new SNSClient({});

async function sendEmailNotification(event) {
    for (const record of event.Records) {
        const message = JSON.parse(record.body);

        const command = new PublishCommand({
            TopicArn: process.env.SNS_TOPIC_ARN,
            Message: `¡Hoy tenés que regar tu planta ${message.plantName}! Último riego: ${message.lastWatering}`,
            Subject: "Recordatorio de Riego de Plantas",
        });

        await sns.send(command); 
    }

    return { statusCode: 200 };
}

module.exports = { 
    sendEmailNotification: sendEmailNotification 
};
