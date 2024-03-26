# Image Scaling Change in AWS Lambda
<hr>
The Lambda script automatically scales images uploaded to an S3 bucket by reducing their dimensions. By default, the script reduces the dimensions of images by half. 
If you wish to change this behavior so that images are scaled by a factor of 'x' instead, you need to modify the calculation of the new image size.
<hr>

# Changing the Scale Factor
To change the scaling factor of images, you need to modify how new_size is calculated in the Lambda script. Below is the code snippet you need to change:
<hr>

``` # Scaling the image by half (originally)
new_size = (int(image.width / 2), int(image.height / 2))```

