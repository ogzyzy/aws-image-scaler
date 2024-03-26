# Image Scaling Change in AWS Lambda
<hr>
The Lambda script automatically scales images uploaded to an S3 bucket by reducing their dimensions. By default, the script reduces the dimensions of images by half. 
If you wish to change this behavior so that images are scaled by a factor of 'x' instead, you need to modify the calculation of the new image size.


## Changing the Scale Factor
To change the scaling factor of images, you need to modify how new_size is calculated in the Lambda script. Below is the code snippet you need to change:

```python
# Scaling the image by a factor of 'x'
new_size = (int(image.width / x), int(image.height * 0.25))
```
This change will result in the image being divided by x.

## Next Steps
After making the above modification, ensure that you have tested the modified script to check if images are scaled as expected. You can do this by uploading test images to your S3 bucket and checking if the resized versions in the destination bucket have the correct dimensions.
