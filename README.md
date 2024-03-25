# AWS Image Scaler

<img width="1041" alt="Screenshot 2024-03-25 at 17 48 49" src="https://github.com/ogzyzy/aws-image-scaler/assets/157073744/8ae62f45-15da-4de4-a32d-94baa7cd2c23">

The application architecture consists of two main components:

**Amazon S3 Bucket:** Serves as the storage for uploaded images. Whenever an image is uploaded to this bucket, it triggers an event.

**AWS Lambda Function:** The heart of the application. It's triggered by events from the S3 bucket. Upon triggering, it retrieves the uploaded image, processes it according to predefined rules, and then stores the processed image to the other S3 bucket.

# Contents

1. [Configure S3 Buckets](#Configuration-of-S3-Buckets)
2. [Configure Lambda service](#Configuration-of-Lambda-service)
3. [Event creation](#Event-creation)
4. [Lambda timeout](#Lambda-timeout)
5. [Lambda policies](#Lambda-policies)
6. [Using the application](#Using-the-application) 

# How I Created an Application

## Configuration of S3 Buckets 

First, I needed to set up an S3 Bucket for uploading images and another one where the processed images would be stored. So, I logged into the AWS console and in the search bar, searched for S3 Bucket.

![Screenshot 2024-02-26 at 16 00 59](https://github.com/ogzyzy/aws-image-scaler/assets/157073744/1396d6a7-1c72-4978-8365-c311dadc9709)

After navigating to the S3 service, I selected "Create Bucket."

![Screenshot 2024-02-26 at 16 02 46](https://github.com/ogzyzy/aws-image-scaler/assets/157073744/9671277d-b270-41dc-be63-641e83b6bdf9)

**I chose my region, the best option being the one closest to me**, and gave a name to my S3 bucket. **The name had to be unique**, and I made sure it indicated that this was the source bucket from which Lambda would fetch images.

<img width="1095" alt="Screenshot 2024-02-26 at 19 32 52" src="https://github.com/ogzyzy/aws-image-scaler/assets/157073744/1b41916c-af37-404d-907e-3cc8f5fb0a07">
<img width="1095" alt="Screenshot 2024-02-26 at 19 32 52" src="https://github.com/ogzyzy/aws-image-scaler/assets/157073744/341eedea-02c7-4e15-8bea-ae4d0db1a47e">

Then, I went into it and created a folder named 'images' where I would place the pictures.
![Screenshot 2024-02-28 at 16 14 04](https://github.com/ogzyzy/aws-image-scaler/assets/157073744/dfcd4028-70af-44fd-82f8-d68fad44720c)
<img width="1095" alt="Screenshot 2024-02-26 at 19 32 52" src="https://github.com/ogzyzy/aws-image-scaler/assets/157073744/3720416c-1f54-4ba5-9b0e-b9ec7478ef05">

I repeated the same process for the **destination bucket** and created a folder named **'resized'** in it.

<img width="1095" alt="Screenshot 2024-02-26 at 19 32 52" src="https://github.com/ogzyzy/aws-image-scaler/assets/157073744/b5918acd-b296-4bed-94f2-a39d00e5c97e">

<hr>


## Configuration of Lambda service


Now, I configured the **Lambda service**. I found it in the search bar.

![Screenshot 2024-02-26 at 16 23 11](https://github.com/ogzyzy/aws-image-scaler/assets/157073744/9451bb1b-bbbc-4863-a917-f6c78880c850)

I selected **"Create a function."**

![Screenshot 2024-02-26 at 16 28 03](https://github.com/ogzyzy/aws-image-scaler/assets/157073744/33f8ef3f-f49e-4da7-9a2d-03bb3aacd3a6)

I selected a **Container image**, then named my Lambda function. I chose an image from the **ECR repository** to which I had previously pushed a container image. I left the architecture at **x86_64** and clicked create function.

<img width="1007" alt="Screenshot 2024-03-25 at 19 14 35" src="https://github.com/ogzyzy/aws-image-scaler/assets/157073744/3703c6a1-999e-44e0-baaf-2513b16743e2">

<hr> 

## Event creation

Now I needed to create an event in the source S3 Bucket. To do this, [I went to the S3 Bucket service.](#Configure-S3-Buckets)
There, I saw the two S3 buckets created earlier. I clicked on the one that serves as the source bucket.

![Screenshot 2024-02-26 at 16 38 59](https://github.com/ogzyzy/aws-image-scaler/assets/157073744/57a87c6c-6936-4432-81f7-e1d8c4c485a8)

I went to properties.

![Screenshot 2024-02-26 at 16 44 05](https://github.com/ogzyzy/aws-image-scaler/assets/157073744/ff6fcc7e-6602-4a04-9c10-0f5b18f3abd6)

I swiped down to event notifications and created one.

![Screenshot 2024-02-26 at 16 44 56](https://github.com/ogzyzy/aws-image-scaler/assets/157073744/9e2eb313-5ad5-450e-8627-ba4ac447d28b)

In the **general configuration**, I provided a **name for our event**, which **does not need to be unique**. In the **prefix**, I specified the folder that we created in the source S3 bucket. I set the **event type as 'put'**.
In the **destination tab**, I selected the **name of the created Lambda service** and left the rest of the options as default. Then, I clicked on **'Save changes'**.

<img width="1095" alt="Screenshot 2024-02-26 at 19 32 52" src="https://github.com/ogzyzy/aws-image-scaler/assets/157073744/5bfdf230-e767-4c37-b958-f4ef0ec5274f">

![Screenshot 2024-02-26 at 16 48 17](https://github.com/ogzyzy/aws-image-scaler/assets/157073744/8a8e736f-de97-4e11-ba0f-5ee38b1c06e9)

After navigating to the Lambda function, I could see that the source bucket had been added as a trigger. Uploading an image to it would trigger the programmed process of scaling.

<img width="1095" alt="Screenshot 2024-02-26 at 19 32 52" src="https://github.com/ogzyzy/aws-image-scaler/assets/157073744/6f085a9f-d24d-428b-95bb-dd3e8009f4b6">

<hr> 

## Lambda timeout

I also needed to adjust the timeout for the Lambda function to ensure the service worked correctly.
To do this, I went to 'Configuration'. In the general configuration, I found an option to edit.

<img width="1095" alt="Screenshot 2024-02-26 at 19 32 52" src="https://github.com/ogzyzy/aws-image-scaler/assets/157073744/2a53923d-b4a2-4f85-b1e4-472727ed1c48">

Change the timeout to 1 minute and save the changes.

<img width="1095" alt="Screenshot 2024-02-26 at 19 32 52" src="https://github.com/ogzyzy/aws-image-scaler/assets/157073744/946710ba-3c06-43ec-a51d-706f19dd517e">

<hr>

## Lambda policies

The Lambda function needed permissions to fully access the S3 resources. So, in the 'Permissions' tab, I navigated to the IAM settings for the Lambda function.

<img width="1095" alt="Screenshot 2024-02-26 at 19 32 52" src="https://github.com/ogzyzy/aws-image-scaler/assets/157073744/f816ca93-9b35-4d90-86bd-268ebe89cf44">

I expanded 'Add permission' and clicked 'Attach policies'.

<img width="1095" alt="Screenshot 2024-02-26 at 19 32 52" src="https://github.com/ogzyzy/aws-image-scaler/assets/157073744/25e61614-2a65-4e43-bb1f-0e0409feeecd">

I found the policy named "AmazonS3FullAccess" and "AmazonEC2ContainerRegistryReadOnly", selected it, and added it.

<img width="1095" alt="Screenshot 2024-02-26 at 19 32 52" src="https://github.com/ogzyzy/aws-image-scaler/assets/157073744/da002dac-e59d-45d0-a0d4-e7163b301500">

<img width="988" alt="Screenshot 2024-03-25 at 17 58 05" src="https://github.com/ogzyzy/aws-image-scaler/assets/157073744/3d7e23e0-b70c-4101-b28d-998a8732cc5a">

<hr>

## Using the application 

To upload a photo to S3, I went to the S3 service, selected the source bucket, and navigated to the 'images' folder. Then, I clicked 'Upload'.

<img width="1095" alt="Screenshot 2024-02-26 at 19 32 52" src="https://github.com/ogzyzy/aws-image-scaler/assets/157073744/30cb5d48-3590-48e1-84a5-ee9e40000226">

I dragged and dropped the file into the designated area or clicked "Add files" to select the photo for upload.

<img width="1095" alt="Screenshot 2024-02-26 at 19 32 52" src="https://github.com/ogzyzy/aws-image-scaler/assets/157073744/5b3a3d2e-f414-4653-b934-15e49ada2fad">

After selecting the files, I clicked on the "Upload" button to upload the photo to the S3 bucket.

<img width="1095" alt="Screenshot 2024-02-26 at 19 32 52" src="https://github.com/ogzyzy/aws-image-scaler/assets/157073744/e40ad3ba-c640-49b5-8935-9dd6d0471749">

By navigating to the resized folder in the destination bucket, we can see scaled image.

<img width="1095" alt="Screenshot 2024-02-26 at 19 32 52" src="https://github.com/ogzyzy/aws-image-scaler/assets/157073744/c0acff34-5903-4340-88ae-17efea548b3b">










