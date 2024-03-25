# Docker image from Amazon ECR Public Gallery
FROM public.ecr.aws/lambda/python:3.12.2024.03.24.02
# Install Pillow exstension
RUN pip install Pillow
# Copy application code
COPY app.py ./
# Execute lambda_handler
CMD ["app.lambda_handler"]


