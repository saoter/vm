#!/bin/bash

set -e  # Exit if any command fails

echo "Updating package list and upgrading system..."
sudo apt-get update && sudo apt-get upgrade -y


echo "Create virual environmet and activate..."
sudo apt install -y python3.12-venv 
python3 -m venv myenv
source myenv/bin/activate


# pip install torch==2.4.1+cu124 torchvision==0.19.1+cu124 --extra-index-url https://download.pytorch.org/whl/cu124

echo "Download Comfyui and install requirements..."
git clone https://github.com/comfyanonymous/ComfyUI
cd ComfyUI
pip install -r requirements.txt
cd


echo "Download Diffusion-pipe and install requirements..."
git clone https://github.com/tdrussell/diffusion-pipe
cd diffusion-pipe
pip install ninja
pip install flash-attn --no-build-isolation --no-cache-dir
pip install -r requirements.txt

echo "Download fluxgym and install requirements..."
cd
git clone https://github.com/cocktailpeanut/fluxgym
cd fluxgym
git clone -b sd3 https://github.com/kohya-ss/sd-scripts
cd sd-scripts
pip install -r requirements.txt
cd ..
pip install -r requirements.txt

sudo apt-get install -y python3.12-dev
pip install --upgrade --force-reinstall triton==2.2.0

echo "Download VS Code and install requirements..."
cd
sudo apt install -y curl wget gnupg
curl -fsSL https://code-server.dev/install.sh | sh
# Enable on boot
systemctl --user enable --now code-server
cd


