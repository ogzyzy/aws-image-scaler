# aws-image-scaler

![Screenshot 2024-02-27 at 16 55 38](https://github.com/ogzyzy/aws-image-scaler/assets/157073744/acfcccf9-b0fe-4ffe-bf8c-3c0383f178b4)
The application architecture consists of three main components:

**Amazon S3 Bucket:** Serves as the storage for uploaded images. Whenever an image is uploaded to this bucket, it triggers an event.

**AWS Lambda Function:** The heart of the application. It's triggered by events from the S3 bucket. Upon triggering, it retrieves the uploaded image, processes it according to predefined rules, and then stores the processed image to the other S3 bucket.

## How to Create an Application

First, we need to set up an S3 Bucket for uploading images and another one where the processed images will be stored. Let's log in to the AWS console and in the search bar, search for S3 Bucket.
![Screenshot 2024-02-26 at 16 00 59](https://github.com/ogzyzy/aws-image-scaler/assets/157073744/7fcfaf67-4a73-4bae-bcef-af038f523f04)

After navigating to the S3 service, select "Create Bucket."
![Screenshot 2024-02-26 at 16 02 46](https://github.com/ogzyzy/aws-image-scaler/assets/157073744/9671277d-b270-41dc-be63-641e83b6bdf9)

Now, choose your region, the best option being the one closest to you, and give a name to your S3 bucket. **The name must be unique**, and it should indicate that this is the source bucket from which Lambda will fetch images.
![Screenshot 2024-02-26 at 16 06 28](https://github.com/ogzyzy/aws-image-scaler/assets/157073744/1b41916c-af37-404d-907e-3cc8f5fb0a07)

Repeat the same process for the destination bucket.
![Screenshot 2024-02-26 at 16 22 31](https://github.com/ogzyzy/aws-image-scaler/assets/157073744/12549d32-0a62-4c6a-ac54-67438266ed56)

Now we configure the Lambda service. You can find it in the search bar.
![Screenshot 2024-02-26 at 16 23 11](https://github.com/ogzyzy/aws-image-scaler/assets/157073744/9451bb1b-bbbc-4863-a917-f6c78880c850)
