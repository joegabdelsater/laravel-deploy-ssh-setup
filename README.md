# Create Deploy User and Setup SSH Keys

Scripts to automate setting up and removing SSH deploy keys for GitHub Actions deployment.

## Usage

On your server run:

```bash
curl -s https://raw.githubusercontent.com/joegabdelsater/laravel-deploy-ssh-setup/main/setup-deploy-key.sh | sudo bash
```


# Remove Deploy Key & Revoke Access

```bash
curl -s https://raw.githubusercontent.com/joegabdelsater/laravel-deploy-ssh-setup/main/remove-deploy-key.sh | sudo bash
```
