# aws-image-scaler

![Screenshot 2024-02-27 at 16 55 38](https://github.com/ogzyzy/aws-image-scaler/assets/157073744/acfcccf9-b0fe-4ffe-bf8c-3c0383f178b4)
The application architecture consists of two main components:

**Amazon S3 Bucket:** Serves as the storage for uploaded images. Whenever an image is uploaded to this bucket, it triggers an event.

**AWS Lambda Function:** The heart of the application. It's triggered by events from the S3 bucket. Upon triggering, it retrieves the uploaded image, processes it according to predefined rules, and then stores the processed image to the other S3 bucket.

# How to Create an Application

## Configure S3 Buckets 

First, we need to set up an S3 Bucket for uploading images and another one where the processed images will be stored. Let's log in to the AWS console and in the search bar, search for S3 Bucket.

![Screenshot 2024-02-26 at 16 00 59](https://github.com/ogzyzy/aws-image-scaler/assets/157073744/7fcfaf67-4a73-4bae-bcef-af038f523f04)

After navigating to the S3 service, select "Create Bucket."

![Screenshot 2024-02-26 at 16 02 46](https://github.com/ogzyzy/aws-image-scaler/assets/157073744/9671277d-b270-41dc-be63-641e83b6bdf9)

Now, **choose your region, the best option being the one closest to you**, and give a name to your S3 bucket. **The name must be unique**, and it should indicate that this is the source bucket from which Lambda will fetch images.

<img width="1095" alt="Screenshot 2024-02-26 at 19 32 52" src="https://github.com/ogzyzy/aws-image-scaler/assets/157073744/1b41916c-af37-404d-907e-3cc8f5fb0a07">
<img width="1095" alt="Screenshot 2024-02-26 at 19 32 52" src="https://github.com/ogzyzy/aws-image-scaler/assets/157073744/341eedea-02c7-4e15-8bea-ae4d0db1a47e">

Then, go into it and create a folder named **'images'** where we will place the pictures.
![Screenshot 2024-02-28 at 16 14 04](https://github.com/ogzyzy/aws-image-scaler/assets/157073744/dfcd4028-70af-44fd-82f8-d68fad44720c)
<img width="1095" alt="Screenshot 2024-02-26 at 19 32 52" src="https://github.com/ogzyzy/aws-image-scaler/assets/157073744/3720416c-1f54-4ba5-9b0e-b9ec7478ef05">

Repeat the same procees for the **destination bucket** and create a folder named **'resized'** in it.

<img width="1095" alt="Screenshot 2024-02-26 at 19 32 52" src="https://github.com/ogzyzy/aws-image-scaler/assets/157073744/b5918acd-b296-4bed-94f2-a39d00e5c97e">

<hr>


### 
Configure Lambda service
---

Now we configure the **Lambda service**. You can find it in the search bar.

![Screenshot 2024-02-26 at 16 23 11](https://github.com/ogzyzy/aws-image-scaler/assets/157073744/9451bb1b-bbbc-4863-a917-f6c78880c850)

Select **"Create a function."**

![Screenshot 2024-02-26 at 16 28 03](https://github.com/ogzyzy/aws-image-scaler/assets/157073744/33f8ef3f-f49e-4da7-9a2d-03bb3aacd3a6)

Here, we need to provide information for our service. The function name **does not need to be unique** like in the case of S3 Buckets. 
For r**untime**, choose **Python 3.12** and **architecture as x86_64**. Leave the rest of the options as default and click **"Create function."**

![Screenshot 2024-02-26 at 16 30 36](https://github.com/ogzyzy/aws-image-scaler/assets/157073744/048fb6ad-a40b-4c50-a104-d1a9c6b6c5b3)

<hr> 

### 
Event creation
---

Now we need to create an event in the source S3 Bucket. To do this, [go to the S3 Bucket service.](#Configure-S3-Buckets)
Here you will see the two S3 buckets created earlier. Click on the one that serves as the source bucket

![Screenshot 2024-02-26 at 16 38 59](https://github.com/ogzyzy/aws-image-scaler/assets/157073744/57a87c6c-6936-4432-81f7-e1d8c4c485a8)

Go to properties.

![Screenshot 2024-02-26 at 16 44 05](https://github.com/ogzyzy/aws-image-scaler/assets/157073744/ff6fcc7e-6602-4a04-9c10-0f5b18f3abd6)

Swipe down to event notifications and create one.

![Screenshot 2024-02-26 at 16 44 56](https://github.com/ogzyzy/aws-image-scaler/assets/157073744/9e2eb313-5ad5-450e-8627-ba4ac447d28b)

In the **general configuration**, provide a **name for our event**, which does **not need to be unique**. In the **prefix, specify the folder that we created in the source S3 bucket**. Set the **event type as 'put'**.
In the **destination tab**, select the **name of the created Lambda service** and leave the rest of the options as default. Click on **'Save changes'**.

<img width="1095" alt="Screenshot 2024-02-26 at 19 32 52" src="https://github.com/ogzyzy/aws-image-scaler/assets/157073744/5bfdf230-e767-4c37-b958-f4ef0ec5274f">

![Screenshot 2024-02-26 at 16 48 17](https://github.com/ogzyzy/aws-image-scaler/assets/157073744/8a8e736f-de97-4e11-ba0f-5ee38b1c06e9)

After navigating to the Lambda function, you can see that the source bucket has been added as a trigger. Uploading an image to it will trigger the programmed process of scaling.

<img width="1095" alt="Screenshot 2024-02-26 at 19 32 52" src="https://github.com/ogzyzy/aws-image-scaler/assets/157073744/6f085a9f-d24d-428b-95bb-dd3e8009f4b6">

<hr> 

### 
Lambda timeout
---

We will also need to adjust the timeout for the Lambda function to ensure the service works correctly.
To do this, go to 'Configuration'. In the general configuration, you will find an option to edit.

<img width="1095" alt="Screenshot 2024-02-26 at 19 32 52" src="https://github.com/ogzyzy/aws-image-scaler/assets/157073744/2a53923d-b4a2-4f85-b1e4-472727ed1c48">

Change the timeout to 1 minute and save the changes.

<img width="1095" alt="Screenshot 2024-02-26 at 19 32 52" src="https://github.com/ogzyzy/aws-image-scaler/assets/157073744/946710ba-3c06-43ec-a51d-706f19dd517e">

<hr>

### Lambda policies

The Lambda function will also need permissions to fully access the S3 resources. To do this, in the 'Permissions' tab, navigate to the IAM settings for the Lambda function.

<img width="1095" alt="Screenshot 2024-02-26 at 19 32 52" src="https://github.com/ogzyzy/aws-image-scaler/assets/157073744/f816ca93-9b35-4d90-86bd-268ebe89cf44">

Expand 'Add permission' and click 'Attach policies'.

<img width="1095" alt="Screenshot 2024-02-26 at 19 32 52" src="https://github.com/ogzyzy/aws-image-scaler/assets/157073744/25e61614-2a65-4e43-bb1f-0e0409feeecd">

Search for the policy named "AmazonS3FullAccess" for S3, select it, and add it.

<img width="1095" alt="Screenshot 2024-02-26 at 19 32 52" src="https://github.com/ogzyzy/aws-image-scaler/assets/157073744/da002dac-e59d-45d0-a0d4-e7163b301500">

<hr>

### 
Code import
---

In the Lambda service, go to the 'Code' tab, and add the code from the repository (image-scaler-code.py). Remember to change the name of the destination bucket to your own. Then, click 'Deploy'.

```
import json
import boto3

s3_client = boto3.client('s3')
dest_bucket_name = 'destination_bucket_name' # Change name of the destination bucket

def lambda_handler(event, context):
    try: 
    
        s3_event = event['Records'][0]['s3']
        
        bucket_name = s3_event['bucket']['name']
        object_key = s3_event['object']['key']

       
        response = s3_client.get_object(Bucket=bucket_name, Key=object_key)
        object_content = response['Body'].read()
        
        resized_response = s3_client.put_object(Body=object_content, Bucket=dest_bucket_name, Key=f'resized/{object_key}' )
    
    
        return {
            'statusCode': 200,
            'body': json.dumps('succesfully scaled image')
        }
        
    except Exception as e:
        print(f'Error {e}')
        return {
            'statusCode': 200,
            'body': json.dumps('Error scaling image')
        }
```

<img width="1095" alt="Screenshot 2024-02-26 at 19 32 52" src="https://github.com/ogzyzy/aws-image-scaler/assets/157073744/edab96a5-5a64-4823-ae61-787ba25f03b0">

<hr>

### 
Using the application 
---

Upload a photo to S3. To do this, go to the S3 service, select the source bucket, and navigate to the 'images' folder. Then, click 'Upload'.

<img width="1095" alt="Screenshot 2024-02-26 at 19 32 52" src="https://github.com/ogzyzy/aws-image-scaler/assets/157073744/30cb5d48-3590-48e1-84a5-ee9e40000226">

Drag and drop or click Add files.

<img width="1095" alt="Screenshot 2024-02-26 at 19 32 52" src="https://github.com/ogzyzy/aws-image-scaler/assets/157073744/5b3a3d2e-f414-4653-b934-15e49ada2fad">

Then click Upload.

<img width="1095" alt="Screenshot 2024-02-26 at 19 32 52" src="https://github.com/ogzyzy/aws-image-scaler/assets/157073744/e40ad3ba-c640-49b5-8935-9dd6d0471749">

By navigating to the resized folder in the destination bucket, you can see your scaled image.

<img width="1095" alt="Screenshot 2024-02-26 at 19 32 52" src="https://github.com/ogzyzy/aws-image-scaler/assets/157073744/c0acff34-5903-4340-88ae-17efea548b3b">










