# aws-image-scaler

![Screenshot 2024-02-27 at 16 55 38](https://github.com/ogzyzy/aws-image-scaler/assets/157073744/acfcccf9-b0fe-4ffe-bf8c-3c0383f178b4)
The application architecture consists of three main components:

**Amazon S3 Bucket:** Serves as the storage for uploaded images. Whenever an image is uploaded to this bucket, it triggers an event.

**AWS Lambda Function:** The heart of the application. It's triggered by events from the S3 bucket. Upon triggering, it retrieves the uploaded image, processes it according to predefined rules, and then stores the processed image to the other S3 bucket.

## How to Create an Application
