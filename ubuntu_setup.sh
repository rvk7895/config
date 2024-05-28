#!/bin/bash

set -e

sudo apt update

sudo apt install -y software-properties-common curl wget git zsh neovim python3-neovim

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
wait

# Install zsh-autosuggestions and zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Configure .zshrc
sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting extract)/' ~/.zshrc
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="gentoo"/' ~/.zshrc
echo 'alias vim="nvim"' >> ~/.zshrc

# Install Vim-Plug https://github.com/junegunn/vim-plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Setup Neovim configuration
NVIM_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
mkdir -p "$NVIM_CONFIG_DIR"
cp ./Nvim/init.vim "$NVIM_CONFIG_DIR/"

# Run PlugInstall for Neovim
echo "Installing Vim plugins..."
nvim --headless +PlugInstall +qall

# Download and install Anaconda
echo "Downloading Anaconda..."
curl -s -L -o ~/anaconda.sh https://repo.anaconda.com/archive/Anaconda3-2024.02-1-Linux-x86_64.sh
echo "Installing Anaconda..."
bash ~/anaconda.sh -b -p $HOME/anaconda
echo 'export PATH="$HOME/anaconda/bin:$PATH"' >> ~/.zshrc
rm ~/anaconda.sh

# Reload zsh configuration
source ~/.zshrc

echo "Setup completed successfully!"
