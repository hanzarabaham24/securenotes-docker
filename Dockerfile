# SecureNotes API — Dockerfile

# A1: small, pinned, official base image (never :latest)
FROM python:3.12-slim

# A2: a home for the app inside the image
WORKDIR /app

# A3: copy requirements first and install, so this layer gets cached
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# A4: bring in the rest of the source
COPY . .

# B1: run as a non-root user
RUN adduser --disabled-password --gecos "" appuser
USER appuser

# A5: expose the port and start the API (0.0.0.0 so it's reachable from outside)
EXPOSE 8000
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
