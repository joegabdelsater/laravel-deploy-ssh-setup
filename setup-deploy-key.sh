#!/bin/bash

# ====== CONFIGURATION ======
SSH_USER="deploy"  # Change to desired username
KEY_NAME="github-actions-deploy"
SSH_DIR="/home/$SSH_USER/.ssh"
SCRIPT_PATH="$0"

echo "Creating user: $SSH_USER"
echo

# ====== Create User ======
if id "$SSH_USER" &>/dev/null; then
  echo "User $SSH_USER already exists. Skipping user creation."
else
  sudo adduser --disabled-password --gecos "" $SSH_USER
  echo "User $SSH_USER created."
fi

# ====== Setup SSH directory ======
sudo -u $SSH_USER mkdir -p $SSH_DIR
sudo chmod 700 $SSH_DIR

# ====== Generate SSH key pair ======
sudo -u $SSH_USER ssh-keygen -t rsa -b 4096 -C "$KEY_NAME" -f "$SSH_DIR/$KEY_NAME" -N ""

# ====== Add public key to authorized_keys ======
sudo -u $SSH_USER cat "$SSH_DIR/$KEY_NAME.pub" >> "$SSH_DIR/authorized_keys"

# ====== Set permissions ======
sudo chown $SSH_USER:$SSH_USER "$SSH_DIR/$KEY_NAME"*
sudo chmod 600 "$SSH_DIR/$KEY_NAME"
sudo chmod 644 "$SSH_DIR/$KEY_NAME.pub"
sudo chmod 600 "$SSH_DIR/authorized_keys"

# ====== Output private key ======
echo
echo "=============================="
echo "COPY & ADD THE FOLLOWING PRIVATE KEY TO YOUR GITHUB SECRETS (e.g., PRODUCTION_SSH_KEY):"
echo "=============================="
echo
sudo cat "$SSH_DIR/$KEY_NAME"
echo
echo "=============================="
echo "Deploy user & key setup complete!"
echo "This script will now remove itself."
echo "=============================="

# ====== Self-delete ======
rm -- "$SCRIPT_PATH"
