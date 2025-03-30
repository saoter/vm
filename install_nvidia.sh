#!/bin/bash

set -e  # Exit if any command fails

echo "🔄 Updating package list and upgrading system..."
sudo apt-get update && sudo apt-get upgrade -y


# Optional: install specific torch version with CUDA (uncomment if needed)
# pip install torch==2.4.1+cu124 torchvision==0.19.1+cu124 --extra-index-url https://download.pytorch.org/whl/cu124

echo "⬇️ Cloning ComfyUI and installing requirements..."
cd ~
git clone https://github.com/comfyanonymous/ComfyUI
cd ComfyUI
pip install -r requirements.txt

echo "⬇️ Cloning Diffusion-pipe and installing requirements..."
cd ~
git clone https://github.com/tdrussell/diffusion-pipe
cd diffusion-pipe
pip install ninja
pip install flash-attn --no-build-isolation --no-cache-dir
pip install -r requirements.txt

echo "⬇️ Cloning FluxGym and installing requirements..."
cd ~
git clone https://github.com/cocktailpeanut/fluxgym
cd fluxgym
git clone -b sd3 https://github.com/kohya-ss/sd-scripts
cd sd-scripts
pip install -r requirements.txt
cd ..
pip install -r requirements.txt

echo "🔁 Reinstalling compatible Triton version..."
pip install --upgrade --force-reinstall triton==2.2.0

echo "🧠 Installing code-server (browser-based VS Code)..."
cd ~
sudo apt install -y curl wget gnupg
curl -fsSL https://code-server.dev/install.sh | sh

echo "🔁 Enabling code-server to start..."
systemctl --user enable --now code-server

echo "✅ Setup complete!"



