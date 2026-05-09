FROM python:3.11-slim

ENV PYTHONUNBUFFERED=1
ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    ffmpeg \
    git \
    libgl1-mesa-glx \
    libglib2.0-0 \
    python3-tk \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Copy dependencies first for better caching
COPY requirements.txt /app/

# Install python packages
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copy the remaining project files
COPY . /app/

# Expose default entrypoint
ENTRYPOINT ["python", "run.py"]
