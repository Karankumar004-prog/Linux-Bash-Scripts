#!/bin/bash

# Script: debian_terminal_customizer.sh
# Description: Customize terminal appearance for any Debian-based Linux distro.
# Author: MrWhite

echo -e "\n🚀 Starting Terminal Customization for Debian-based Systems..."

# === 1. Install required tools ===
echo -e "\n🔧 Installing: figlet, lolcat, neofetch, bash-completion..."
sudo apt update && sudo apt install -y figlet lolcat neofetch bash-completion

# === 2. Detect Linux distribution ===
DISTRO_NAME=$(grep '^PRETTY_NAME=' /etc/os-release | cut -d= -f2 | tr -d '"' | awk '{print $1}')
WELCOME_MSG="Welcome to ${DISTRO_NAME^} Shell"

# === 3. Backup existing .bashrc ===
BASHRC="$HOME/.bashrc"
if [ ! -f "$HOME/.bashrc.backup" ]; then
    echo -e "📦 Backing up current .bashrc to ~/.bashrc.backup"
    cp "$BASHRC" "$HOME/.bashrc.backup"
fi

# === 4. Append customization to .bashrc ===
echo -e "🎨 Applying terminal appearance changes..."

cat << EOF >> "$BASHRC"

# ==== Custom Terminal Theme Start ====
clear
figlet "$WELCOME_MSG" | lolcat
neofetch

# Enable bash completion
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# Custom prompt: {username}@{host} in orange, current dir in light green
PS1='\[\e[1;38;5;208m\]\u@\h\[\e[0m\]:\[\e[1;38;5;118m\]\w\[\e[0m\]\\$ '

# Enable colored output for ls and grep
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# Set LS_COLORS for directories, files, etc.
export LS_COLORS='di=1;38;5;208:fi=0;33:ln=36:pi=40;33:so=01;35:do=01;35:bd=01;33:cd=01;33:or=01;31:mi=01;31:ex=0;37'

# Useful aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias cls='clear'
alias update='sudo apt update && sudo apt upgrade -y'
# ==== Custom Terminal Theme End ====
EOF

# === 5. Optional: Apply to root user ===
if [ "$EUID" -ne 0 ]; then
    ROOT_BASHRC="/root/.bashrc"
    sudo bash -c "grep -q '$WELCOME_MSG' $ROOT_BASHRC || (
        cp $ROOT_BASHRC $ROOT_BASHRC.backup 2>/dev/null || true
        echo -e \"\n# ==== Custom Terminal Theme Start ====\" >> $ROOT_BASHRC
        echo 'clear' >> $ROOT_BASHRC
        echo 'figlet \"$WELCOME_MSG\" | lolcat' >> $ROOT_BASHRC
        echo 'neofetch' >> $ROOT_BASHRC
        echo 'if [ -f /etc/bash_completion ]; then . /etc/bash_completion; fi' >> $ROOT_BASHRC
        echo \"PS1='\\[\\e[1;38;5;208m\\]\\u@\\h\\[\\e[0m\\]:\\[\\e[1;38;5;118m\\]\\w\\[\\e[0m\\]# '\" >> $ROOT_BASHRC
        echo \"export LS_COLORS='di=1;38;5;208:fi=0;33:ln=36:pi=40;33:so=01;35:do=01;35:bd=01;33:cd=01;33:or=01;31:mi=01;31:ex=0;37'\" >> $ROOT_BASHRC
        echo 'alias ls=\"ls --color=auto\"' >> $ROOT_BASHRC
        echo 'alias grep=\"grep --color=auto\"' >> $ROOT_BASHRC
        echo 'alias ll=\"ls -alF\"; alias la=\"ls -A\"; alias l=\"ls -CF\"; alias cls=\"clear\"; alias update=\"apt update && apt upgrade -y\"' >> $ROOT_BASHRC
        echo \"# ==== Custom Terminal Theme End ====\" >> $ROOT_BASHRC
    )"
fi

# === 6. Reload the .bashrc ===
echo -e "\n🔁 Reloading shell configuration..."
source "$BASHRC"

echo -e "\n✅ Done! Your terminal now reflects the style of your distro: $DISTRO_NAME"
