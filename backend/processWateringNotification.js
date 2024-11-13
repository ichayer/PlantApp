const { SNSClient, PublishCommand } = require("@aws-sdk/client-sns");

const sns = new SNSClient({});

async function processWateringNotification() {
    console.log('Recibiendo trigger de Event Bridge');

    try {
            const notificationMessage = `
                ¡Revisá si tenés que regar tu planta hoy en nuestra App!

                Saludos,
                PlantApp
                            `;

            const command = new PublishCommand({
                TopicArn: process.env.SNS_EMAIL_TOPIC_ARN,
                Message: notificationMessage,
                Subject: "Recordatorio de Riego - PlantApp"
            });

            console.log('Enviando notificación:', {
                topicArn: process.env.SNS_EMAIL_TOPIC_ARN,
                message: notificationMessage,
                subject: "Recordatorio de Riego - PlantApp"
            });

            const result = await sns.send(command);
            console.log('Notificación enviada exitosamente:', result);

        return { 
            statusCode: 200,
            body: JSON.stringify({
                message: "Notificaciones enviadas exitosamente"
            })
        };

    } catch (error) {
        console.error('Error procesando notificaciones:', {
            error: error.message,
            stack: error.stack
        });
        
        throw error;
    }
}

module.exports = { 
    processWateringNotification: processWateringNotification 
};