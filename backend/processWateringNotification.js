const { SNSClient, PublishCommand } = require("@aws-sdk/client-sns");

const sns = new SNSClient({});

async function processWateringNotification(event) {
    console.log('Recibiendo eventos de SQS:', JSON.stringify(event));

    try {
        for (const record of event.Records) {
            console.log('Procesando record:', record);
            const message = JSON.parse(record.body);
            
            const nextWateringDate = new Date(message.nextWateringDate).toLocaleDateString('es-ES', {
                weekday: 'long',
                year: 'numeric',
                month: 'long',
                day: 'numeric'
            });

            const notificationMessage = `
                ¡Has regado exitosamente tu planta ${message.plantName}!

                Próximo riego: ${nextWateringDate}

                Saludos,
                PlantApp
                            `;

            const command = new PublishCommand({
                TopicArn: process.env.SNS_EMAIL_TOPIC_ARN,
                Message: notificationMessage,
                Subject: "Confirmación de Riego - PlantApp"
            });

            console.log('Enviando notificación:', {
                topicArn: process.env.SNS_EMAIL_TOPIC_ARN,
                message: notificationMessage,
                subject: "Confirmación de Riego - PlantApp",
                plantName: message.plantName,
                nextWatering: nextWateringDate
            });

            const result = await sns.send(command);
            console.log('Notificación enviada exitosamente:', result);
        }

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