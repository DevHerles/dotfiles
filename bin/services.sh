#!/bin/bash

if [[ "$1" == "" ]] || [[ "$2" == "" ]]
then
    echo "Use: service.sh {docker|postgres} {stop|start}"
    exit
fi

if [[ "$1" == "docker" ]]; then
    if [[ "$2" == "stop" ]]; then
        echo "Stopping Docker service..."
        sudo systemctl stop docker.service
        sudo systemctl stop docker.socket
       echo "Docker is stopped"
    elif [[ "$2" == "start" ]]; then
       echo "Starting Docker service..."
       sudo systemctl start docker.service
       sudo systemctl start docker.socket
       echo "Docker is ready to use"
    else 
       echo "Use: service.sh docker {stop|start}"
    fi
    sudo service docker status
elif [[ "$1" == "postgres" ]]; then
    if [[ "$2" == "stop" ]]; then
        echo "Stopping PostreSQL service..."
        sudo systemctl stop postgresql.service
       echo "PostgreSQL is stopped"
    elif [[ "$2" == "start" ]]; then
       echo "Starting PostgreSQL service..."
       sudo systemctl start postgresql.service
       echo "PostgreSQL is ready to use"
    else 
       echo "Use: service.sh postgres {stop|start}"
    fi
    sudo service postgresql status
else
    echo "Use: service.sh {docker|postgres} {stop|start}"
fi


