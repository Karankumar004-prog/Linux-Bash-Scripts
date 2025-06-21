#!/bin/bash

# Author: ChatGPT
# Description: Make Ubuntu terminal behave like Kali, with full customization

echo -e "\n🚀 Starting Ubuntu to Kali-like terminal transformation..."

# === 1. Install necessary packages ===
echo -e "\n🔧 Installing dependencies: figlet, lolcat, neofetch, bash-completion..."
sudo apt update && sudo apt install -y figlet lolcat neofetch bash-completion

# === 2. Backup existing .bashrc ===
BASHRC="$HOME/.bashrc"
BACKUP="$HOME/.bashrc.backup"
if [ ! -f "$BACKUP" ]; then
    echo -e "📦 Backing up current .bashrc to ~/.bashrc.backup"
    cp "$BASHRC" "$BACKUP"
fi

# === 3. Apply terminal appearance and color config ===
echo -e "🎨 Applying new terminal theme..."

cat << 'EOF' >> "$BASHRC"

# ==== Kali Terminal Style Start ====
# Show banner
clear
figlet "Welcome to Kali Shell" | lolcat
neofetch

# Enable bash completion
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# Custom PS1 Prompt
# \u = username | \h = hostname | \w = working dir
PS1='\[\e[1;38;5;208m\]\u@\h\[\e[0m\]:\[\e[1;38;5;118m\]\w\[\e[0m\]$ '

# Colored LS and GREP aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# Enhanced color scheme for files
export LS_COLORS='di=1;38;5;208:fi=0;33:ln=36:pi=40;33:so=01;35:do=01;35:bd=01;33:cd=01;33:or=01;31:mi=01;31:ex=0;37'

# Aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias cls='clear'
alias update='sudo apt update && sudo apt upgrade -y'

# ==== Kali Terminal Style End ====
EOF

# === 4. Update root user .bashrc as well if needed ===
if [ "$EUID" -ne 0 ]; then
    ROOT_BASHRC="/root/.bashrc"
    echo -e "👑 Applying the same setup for root user..."

    sudo bash -c "cp $ROOT_BASHRC $ROOT_BASHRC.backup 2>/dev/null || true"
    sudo bash -c "cat << 'EOF' >> $ROOT_BASHRC

# ==== Kali Terminal Style Start ====
clear
figlet 'Root Shell' | lolcat
neofetch

if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

PS1='\[\e[1;38;5;208m\]\u@\h\[\e[0m\]:\[\e[1;38;5;118m\]\w\[\e[0m\]# '

alias ls='ls --color=auto'
alias grep='grep --color=auto'

export LS_COLORS='di=1;38;5;208:fi=0;33:ln=36:pi=40;33:so=01;35:do=01;35:bd=01;33:cd=01;33:or=01;31:mi=01;31:ex=0;37'

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias cls='clear'
alias update='apt update && apt upgrade -y'

# ==== Kali Terminal Style End ====
EOF"
fi

# === 5. Reload .bashrc ===
echo -e "\n🔁 Reloading terminal configuration..."
source "$BASHRC"

echo -e "\n✅ All done! Reopen your terminal or run: source ~/.bashrc"

