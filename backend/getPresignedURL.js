const { S3Client, PutObjectCommand } = require('@aws-sdk/client-s3');
const { getSignedUrl } = require('@aws-sdk/s3-request-presigner');

const s3 = new S3Client({ region: process.env.AWS_REGION });
const uploadBucket = process.env.S3_IMAGES_BUCKET_NAME;
const URL_EXPIRATION_SECONDS = 30000;

async function getPresignedURL(event) {
  const randomID = parseInt(Math.random() * 10000000);
  const Key = `${randomID}.mp3`;

  const s3Params = {
    Bucket: uploadBucket,
    Key,
    ContentType: 'image/jpeg'
  };

  const command = new PutObjectCommand(s3Params);
  const uploadURL = await getSignedUrl(s3, command, { expiresIn: URL_EXPIRATION_SECONDS });

  return {
    statusCode: 200,
    isBase64Encoded: false,
    headers: {
      "Access-Control-Allow-Origin": "*"
    },
    body: JSON.stringify({
      uploadURL,
      filename: Key
    })
  };
}

exports.getPresignedURL = async (event) => {
  return await getPresignedURL(event);
};
