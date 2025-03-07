# Stage 1: Build
FROM python:3.9-alpine AS builder

WORKDIR /app
COPY requirements.txt .
RUN apk add --no-cache gcc musl-dev && \
    pip install --no-cache-dir --prefix=/install -r requirements.txt && \
    apk del gcc musl-dev

# Stage 2: Final Image
FROM python:3.9-alpine

WORKDIR /app
COPY --from=builder /install /usr/local
COPY . .

CMD ["python", "app.py"]
