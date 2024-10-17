#!/bin/bash

# Function to deploy all stacks
deploy_stacks() {
    echo "Deploying Traefik stack..."
    docker stack deploy -c ./traefik/docker-compose.yml traefik 

    echo "Deploying HAProxy stack..."
    docker stack deploy -c ./ha/ha-stack.yml haproxy 

    echo "Deploying MariaDB Galera stack..."
    docker stack deploy -c ./mariadb/mariadb-stack.yml mariadb 

    #echo "Deploying Nexus stack..."
    #docker stack deploy -c ./nexus/docker-compose.yml nexus 

    echo "Deploying PostgreSQL (pgpool) stack..."
    docker stack deploy -c ./postgres/pgpool-stack.yml postgres 

    echo "Deploying Redis stack..."
    docker stack deploy -c ./redis/redis_ahmad.yml redis 

    echo "Deploying WordPress stack..."
    docker stack deploy -c ./wordpress/wordpress-stack.yml wordpress 

    echo "Deploying Voting app stack..."
    docker stack deploy -c ./vote/docker-stack.yml vote 

    echo "All stacks deployed successfully."
}

# Function to remove all stacks
remove_stacks() {
    echo "Removing Voting app stack..."
    docker stack rm vote

    echo "Removing WordPress stack..."
    docker stack rm wordpress

    echo "Removing Redis stack..."
    docker stack rm redis

    echo "Removing PostgreSQL (pgpool) stack..."
    docker stack rm postgres

    echo "Removing Nexus stack..."
    docker stack rm nexus

    echo "Removing MariaDB Galera stack..."
    docker stack rm mariadb

    echo "Removing HAProxy stack..."
    docker stack rm haproxy

    echo "Removing Traefik stack..."
    docker stack rm traefik

    echo "All stacks removed successfully."
}

# Function to print the menu
menu() {
    echo "Please choose an option:"
    echo "1. Deploy all stacks"
    echo "2. Remove all stacks"
    echo "3. Exit"
}

# Function to handle user input
handle_input() {
    case $1 in
        1)
            deploy_stacks
            ;;
        2)
            remove_stacks
            ;;
        3)
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo "Invalid option. Please choose 1, 2, or 3."
            ;;
    esac
}

# Main loop to show the menu and get user input
while true; do
    menu
    read -p "Enter your choice: " choice
    handle_input $choice
done
