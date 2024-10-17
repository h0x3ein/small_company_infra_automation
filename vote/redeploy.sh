#!/bin/bash

# Set your Docker Hub username
DOCKER_USERNAME="h0x3ein"

# Define image names
VOTE_IMAGE="$DOCKER_USERNAME/examplevotingapp_vote"
WORKER_IMAGE="$DOCKER_USERNAME/examplevotingapp_worker"
RESULT_IMAGE="$DOCKER_USERNAME/examplevotingapp_result"

# Remove the current stack
echo "Removing the current 'vote' stack..."
docker stack rm vote

# Wait for the stack to be fully removed
echo "Waiting for the stack to be removed..."
sleep 10

# Build Docker images
echo "Building the vote app Docker image..."
docker build -t $VOTE_IMAGE ./vote/

echo "Building the worker app Docker image..."
docker build -t $WORKER_IMAGE ./worker/

echo "Building the result app Docker image..."
docker build -t $RESULT_IMAGE ./result/

# Push Docker images to Docker Hub
echo "Pushing vote app image to Docker Hub..."
docker push $VOTE_IMAGE

echo "Pushing worker app image to Docker Hub..."
docker push $WORKER_IMAGE

echo "Pushing result app image to Docker Hub..."
docker push $RESULT_IMAGE

# Deploy the updated stack
echo "Deploying the updated stack..."
docker stack deploy -c docker-stack.yml vote

echo "Done! The updated 'vote' stack has been deployed."
