# aws-image-scaler

![Screenshot 2024-02-27 at 16 55 38](https://github.com/ogzyzy/aws-image-scaler/assets/157073744/acfcccf9-b0fe-4ffe-bf8c-3c0383f178b4)
The application architecture consists of two main components:

**Amazon S3 Bucket:** Serves as the storage for uploaded images. Whenever an image is uploaded to this bucket, it triggers an event.

**AWS Lambda Function:** The heart of the application. It's triggered by events from the S3 bucket. Upon triggering, it retrieves the uploaded image, processes it according to predefined rules, and then stores the processed image to the other S3 bucket.

## How to Create an Application

### Configure S3 Buckets
First, we need to set up an S3 Bucket for uploading images and another one where the processed images will be stored. Let's log in to the AWS console and in the search bar, search for S3 Bucket.
![Screenshot 2024-02-26 at 16 00 59](https://github.com/ogzyzy/aws-image-scaler/assets/157073744/7fcfaf67-4a73-4bae-bcef-af038f523f04)

After navigating to the S3 service, select "Create Bucket."
![Screenshot 2024-02-26 at 16 02 46](https://github.com/ogzyzy/aws-image-scaler/assets/157073744/9671277d-b270-41dc-be63-641e83b6bdf9)

Now, **choose your region, the best option being the one closest to you**, and give a name to your S3 bucket. **The name must be unique**, and it should indicate that this is the source bucket from which Lambda will fetch images.
![Screenshot 2024-02-26 at 16 06 28](https://github.com/ogzyzy/aws-image-scaler/assets/157073744/1b41916c-af37-404d-907e-3cc8f5fb0a07)

Repeat the same process for the **destination bucket**.
![Screenshot 2024-02-26 at 16 22 31](https://github.com/ogzyzy/aws-image-scaler/assets/157073744/12549d32-0a62-4c6a-ac54-67438266ed56)

Now we configure the **Lambda service**. You can find it in the search bar.
![Screenshot 2024-02-26 at 16 23 11](https://github.com/ogzyzy/aws-image-scaler/assets/157073744/9451bb1b-bbbc-4863-a917-f6c78880c850)

Select **"Create a function."**
![Screenshot 2024-02-26 at 16 28 03](https://github.com/ogzyzy/aws-image-scaler/assets/157073744/33f8ef3f-f49e-4da7-9a2d-03bb3aacd3a6)

Here, we need to provide information for our service. The function name **does not need to be unique** like in the case of S3 Buckets. 
For r**untime**, choose **Python 3.12** and **architecture as x86_64**. Leave the rest of the options as default and click **"Create function."**
![Screenshot 2024-02-26 at 16 30 36](https://github.com/ogzyzy/aws-image-scaler/assets/157073744/048fb6ad-a40b-4c50-a104-d1a9c6b6c5b3)

Now we need to create an event in the source S3 Bucket. To do this, [go to the S3 Bucket service.](#Configure-S3-Buckets)
Here you will see the two S3 buckets created earlier. Click on the one that serves as the source bucket
![Screenshot 2024-02-26 at 16 38 59](https://github.com/ogzyzy/aws-image-scaler/assets/157073744/57a87c6c-6936-4432-81f7-e1d8c4c485a8)

Go to properties.
![Screenshot 2024-02-26 at 16 44 05](https://github.com/ogzyzy/aws-image-scaler/assets/157073744/ff6fcc7e-6602-4a04-9c10-0f5b18f3abd6)

Swipe down to event notifications and create one.
![Screenshot 2024-02-26 at 16 44 56](https://github.com/ogzyzy/aws-image-scaler/assets/157073744/9e2eb313-5ad5-450e-8627-ba4ac447d28b)

In the general configuration, provide a **name for our event**, which does **not need to be unique**. In the **prefix, specify the folder that we opened in the source S3 bucket**. Set the **event type as 'put'**.
![Screenshot 2024-02-26 at 16 48 17](https://github.com/ogzyzy/aws-image-scaler/assets/157073744/f93f5482-dc7d-4a9e-8241-24540267eff7)



