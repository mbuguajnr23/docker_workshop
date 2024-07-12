# Stage 1: Build Stage
FROM python:3.8.3-slim AS builder

WORKDIR /workshop

# Copy only the requirements file to install dependencies
COPY requirements.txt requirements.txt

# Install dependencies
RUN pip install -r requirements.txt

# Stage 2: Final Stage
FROM python:3.8.3-slim

WORKDIR /app

# Copy the installed dependencies from the build stage

COPY --from=builder /usr/local/bin /usr/local/bin

# Copy the rest of the application code

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
