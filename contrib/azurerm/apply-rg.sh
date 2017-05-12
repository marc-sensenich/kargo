#!/usr/bin/env bash

set -e

AZURE_RESOURCE_GROUP="$1"

if [ "$AZURE_RESOURCE_GROUP" == "" ]; then
    echo "AZURE_RESOURCE_GROUP is missing"
    exit 1
fi

ansible-playbook generate-templates.yml

az group deployment create --template-file ./.generated/network.json --resource-group $AZURE_RESOURCE_GROUP
az group deployment create --template-file ./.generated/storage.json --resource-group $AZURE_RESOURCE_GROUP
az group deployment create --template-file ./.generated/availability-sets.json --resource-group $AZURE_RESOURCE_GROUP
az group deployment create --template-file ./.generated/bastion.json --resource-group $AZURE_RESOURCE_GROUP
az group deployment create --template-file ./.generated/masters.json --resource-group $AZURE_RESOURCE_GROUP
az group deployment create --template-file ./.generated/minions.json --resource-group $AZURE_RESOURCE_GROUP