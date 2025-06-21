# Linux-Bash-Scripts
Here are some scripts for automation, customization and for ethical hacking.

Customiztion:
1) Modifyshell.sh 
        This Bash script customizes the default terminal appearance for Debian-based Linux distributions (like Ubuntu, Kali, Parrot OS, etc.) to give it a more modern, readable, and hacker-friendly interface.

        🎨 Terminal Color & Style Modifications
        ✅ Prompt Customization (PS1):
        Displays the terminal prompt in a clean, color-coded format:
        {username}@{hostname} → bold orange
        Current directory (PWD) → light green
        Looks consistent across both normal and root users.
        
        ✅ Colored File Listings (ls, ll, etc.):
        Uses a customized LS_COLORS scheme:
        Directories: bold orange
        Regular files: yellow
        Executable files: white
        Symbolic links: cyan
        Ensures improved visibility in large or complex directory trees.
        
        ✅ Command & Error Display:
        Commands appear in white for clarity.
        Errors (stderr) are displayed in red, preserving Bash's default behavior.

        🖼️ Terminal Banner Enhancements
        ✅ Welcome Banner:
        On opening a new terminal session, the screen:
        Clears automatically
        Displays a custom ASCII banner using figlet, piped through lolcat for a vibrant, colored splash
        
        ✅ System Info Display:
        Launches neofetch on each new session
        Shows a clean summary of your OS, hardware, memory, uptime, and more — Kali-style
        
        📦 Additional Features
        Installs required tools: figlet, lolcat, neofetch, and bash-completion
        Supports tab-completion for commands and file paths (via bash-completion)
        Automatically backs up your existing .bashrc before applying changes
        Works seamlessly for both non-root and root users
        Use this script to instantly enhance your terminal environment for better clarity, readability, and that Kali Linux aesthetic — all without changing your OS.

           Here is a Look:
                ![image](https://github.com/user-attachments/assets/d123bcf4-acb7-4868-80db-ada4c4b97f1d)
