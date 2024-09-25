# Use the official Python image as a base
FROM python:3.9-alpine

# Set the working directory
WORKDIR /app

# Copy the requirements file (create this file next)
COPY requirements.txt .

# Install the required packages
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code into the container
COPY app.py .

# Set the environment variable to indicate the Flask app
ENV FLASK_APP=app.py

# Expose the port the app runs on
EXPOSE 5000

# Command to run the application
CMD ["flask", "run", "--host=0.0.0.0"]
