# Minimal Langflow image for Fly.io

FROM python:3.11-slim

ENV LANGFLOW_PORT=7860
ENV LANGFLOW_HOST=0.0.0.0
ENV PYTHONUNBUFFERED=1

# Install system dependencies needed to build Python packages
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       build-essential \
       curl \
       git \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Install a stable Langflow version from PyPI
RUN pip install --no-cache-dir "langflow==1.5.1"

# Create a non root user
RUN useradd -m appuser
USER appuser

EXPOSE 7860

# Start Langflow
CMD ["langflow", "run", "--host", "0.0.0.0", "--port", "7860", "--workers", "1"]
