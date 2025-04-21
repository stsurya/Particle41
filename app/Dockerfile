# Use a minimal base image
FROM python:3.9-slim

# Create a non-root user
RUN useradd -m appuser

# Set working directory and switch to non-root user
WORKDIR /home/appuser
USER appuser

# Copy and install dependencies
COPY --chown=appuser:appuser requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Copy app code
COPY --chown=appuser:appuser app.py .

# Run the app
CMD ["python", "app.py"]