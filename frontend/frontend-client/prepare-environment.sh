#!/bin/bash

# Exit if no argument is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <env-file>"
  exit 1
fi

# Load environment variables from the provided file
source "$1"
echo "Importing variables from $1..."

# Define the sonar properties file
SONAR_PROPERTIES_FILE="sonar-project.properties"

# Check if sonar.host.url is already present
if grep -q "^sonar.host.url=" "$SONAR_PROPERTIES_FILE"; then
  echo "sonar.host.url already exists in $SONAR_PROPERTIES_FILE. Skipping update."
else
  echo -e "\nsonar.host.url=$SONAR_HOST_URL" >> "$SONAR_PROPERTIES_FILE"
  echo "Added sonar.host.url to $SONAR_PROPERTIES_FILE."
fi

# Check if sonar.login is already present
if grep -q "^sonar.login=" "$SONAR_PROPERTIES_FILE"; then
  echo "sonar.login already exists in $SONAR_PROPERTIES_FILE. Skipping update."
else
  echo -e "\nsonar.login=$SONAR_TOKEN" >> "$SONAR_PROPERTIES_FILE"
  echo "Added sonar.login to $SONAR_PROPERTIES_FILE."
fi
