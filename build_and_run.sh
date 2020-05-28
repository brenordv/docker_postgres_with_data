#!/bin/bash
echo "Setting exit on error..."
set -e

sudo docker build -t post:latest .
sudo docker run -d --env-file ./postgres.env.list -p 5432:5432 -p 5433:5433 --restart=unless-stopped --hostname local_postgres.local --name=postgres -it post