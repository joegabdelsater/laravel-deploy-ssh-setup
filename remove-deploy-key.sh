#!/bin/bash

SSH_USER="deploy"
KEY_NAME="github-actions-deploy"
SSH_DIR="/home/$SSH_USER/.ssh"

echo "Removing SSH deploy key for user: $SSH_USER"
echo "Key name: $KEY_NAME"
echo

# Remove key files
sudo rm -f "$SSH_DIR/$KEY_NAME" "$SSH_DIR/$KEY_NAME.pub"

# Remove from authorized_keys
sudo sed -i "/$KEY_NAME/d" "$SSH_DIR/authorized_keys"

echo "Key removed and cleaned up."
