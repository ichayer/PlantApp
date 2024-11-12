import {apiPath} from "../lib/utils";

async function uploadImageWithPresignedUrl(image: Blob, presignedUrl: string): Promise<string | undefined> {
    try {
        const response = await fetch(presignedUrl, {
            method: 'PUT',
            headers: {
                'Content-Type': 'image/jpeg'
            },
            body: image
        });

        if (!response.ok) {
            throw new Error(`Error uploading image: ${response.statusText}`);
        }

        console.log(response)

        return response.url.split("?")[0];
    } catch (error) {
        console.error("Failed to upload image", error);
        return undefined;
    }
}

export async function handleImageUpload(image: Uint8Array ): Promise<string | undefined> {
    try {
        const accessToken = sessionStorage.getItem("accessToken");
        const headers = {
            "Content-Type": "application/json",
            "authorization": `Bearer ${accessToken}`
        };

        const presignedUrlResponse = await fetch(`${apiPath}/getPresignedURL`, {
            method: 'GET',
            headers: headers
        });

        const presignedData = await presignedUrlResponse.json();
        const blob = new Blob([image], { type: "image/jpeg" });

        return await uploadImageWithPresignedUrl(blob, presignedData.uploadURL);
    } catch (error) {
        console.error("Failed to get presigned URL or upload image", error);
        return undefined;
    }
}

