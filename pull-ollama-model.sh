#!/bin/sh

show_error() {
  echo ''
  echo '========================================'
  echo '!!!!!!!!!!  ERROR  !!!!!!!!!!'
  echo '========================================'
  echo 'OLLAMA MODEL PULLER FAILED!'
  echo ''
  echo "$1"
  echo ''
  echo 'Check the logs above for details.'
  echo '========================================'
  echo ''
  exit 1
}

MAX_WAIT=150
CHECK_INTERVAL=2
MAX_ATTEMPTS=$((MAX_WAIT / CHECK_INTERVAL))

echo 'Waiting for Ollama container to start...'
ATTEMPTS=0
CONTAINER_NAME=''
while [ $ATTEMPTS -lt $MAX_ATTEMPTS ]; do
  CONTAINER_NAME=$(docker ps --filter 'name=ollama' --format '{{.Names}}' | head -1)
  if [ -n "$CONTAINER_NAME" ]; then
    echo "Found container: $CONTAINER_NAME"
    break
  fi
  ATTEMPTS=$((ATTEMPTS + 1))
  sleep $CHECK_INTERVAL
done

if [ -z "$CONTAINER_NAME" ]; then
  show_error 'Ollama container did not start within 2.5 minutes. Please check the ollama service logs.'
fi

echo 'Waiting for Ollama API to be ready...'
ATTEMPTS=0
while [ $ATTEMPTS -lt $MAX_ATTEMPTS ]; do
  if docker exec "$CONTAINER_NAME" sh -c 'curl -s http://localhost:11434/api/tags > /dev/null 2>&1' 2>/dev/null; then
    echo 'Ollama API is ready!'
    break
  fi
  ATTEMPTS=$((ATTEMPTS + 1))
  sleep $CHECK_INTERVAL
done

if [ $ATTEMPTS -eq $MAX_ATTEMPTS ]; then
  show_error 'Ollama API did not become ready within 2.5 minutes. Please check the ollama service logs.'
fi

echo 'Pulling llama3.2:1b model...'
if ! docker exec "$CONTAINER_NAME" ollama pull llama3.2:1b; then
  show_error 'Failed to pull llama3.2:1b model. Check the error messages above for details.'
fi

echo ''
echo '========================================'
echo 'SUCCESS!'
echo '========================================'
echo 'Model llama3.2:1b has been pulled successfully!'
echo '========================================'
echo ''

