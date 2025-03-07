# Use a smaller base image
FROM python:3.9-alpine

# Set the working directory
WORKDIR /app

# Copy only the requirements file first to leverage Docker layer caching
COPY requirements.txt .

# Install dependencies and remove cache to reduce image size
RUN apk add --no-cache gcc musl-dev && \
    pip install --no-cache-dir -r requirements.txt && \
    apk del gcc musl-dev

# Copy the rest of the application code
COPY . .

# Run the application
CMD ["python", "app.py"]
