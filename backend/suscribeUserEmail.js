const { SNSClient, SubscribeCommand } = require("@aws-sdk/client-sns");

const sns = new SNSClient({});

exports.suscribeUserEmail = async (event) => {
    try {
            const email = event.request.userAttributes.email;

            if (!email) {
                throw new Error("No se encontró el email en el evento de confirmación.");
            }

            const params = {
                Protocol: 'email',         
                TopicArn: process.env.SNS_EMAIL_TOPIC_ARN, 
                Endpoint: email,
            };
            console.log("Params: ", params)

            const command = new SubscribeCommand(params);
            const result = await sns.send(command);
            console.log("Usuario suscrito al SNS:", result.SubscriptionArn);
            return event
        } catch (error) {
            console.error("Error al suscribir el usuario al SNS:", error);
            throw new Error("Error al suscribir el usuario al SNS: " + error.message);
        }
};