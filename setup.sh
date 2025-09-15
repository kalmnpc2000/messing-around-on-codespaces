#!/bin/bash

# Color codes
GREEN="\e[32m"
YELLOW="\e[33m"
RESET="\e[0m"

# Function for system update and basic setup
system_setup() {
    echo -e "${GREEN}Updating and upgrading system packages...${RESET}"
    sudo apt update -y
    sudo apt upgrade -y

    echo -e "${GREEN}Installing commonly used CLI packages...${RESET}"
    sudo apt install -y \
        nano \
        neofetch \
        git \
        curl \
        build-essential \
        unzip \
        vim \
        htop \
        tree \
        zip \
        wget \
        software-properties-common \
        python3-pip \
        python3-dev \
        python3-venv \
        bash-completion \
        yt-dlp \
        neovim \
        tmux \
        ranger \
        xclip \
        nikto \
        sqlmap \
        hydra \
        nmap \
        metasploit-framework \
        dirb \
        john \
        wfuzz \
        dnsutils \
        net-tools \
        proxychains4 \
        gobuster \
        aircrack-ng \
        netcat \
        tcpdump \
        screen
}

# Run the setup function
system_setup

# Final update and upgrade for every package
sudo apt update -y && sudo apt upgrade -y

# Run functions for each tool (same as you provided)
run_nano() { nano; }
run_neofetch() { neofetch; }
run_git() { git --version; echo "Git installed!"; }
run_curl() { curl --version; }
run_vim() { vim; }
run_htop() { htop; }
run_tree() { tree --version; }
run_wget() { wget --version; }
run_python3_pip() { pip3 --version; }
run_yt_dlp() { yt-dlp --version; }
run_neovim() { nvim; }
run_tmux() { tmux; }
run_ranger() { ranger; }
run_xclip() { echo "xclip copies data to clipboard from CLI"; }

run_nikto() { nikto -H; }
run_sqlmap() { sqlmap --help | head -20; }
run_hydra() { hydra -h | head -20; }
run_nmap() { nmap --version; }
run_msfconsole() { sudo msfconsole; }
run_dirb() { dirb; }
run_john() { john --help | head -20; }
run_wfuzz() { wfuzz --help | head -20; }
run_dnsutils() { dig google.com; }
run_net_tools() { ifconfig; }
run_proxychains4() { echo "Run proxychains4 with: proxychains4 <command>"; }
run_gobuster() { gobuster -h | head -20; }
run_aircrack_ng() { aircrack-ng --help | head -20; }

run_netcat() { nc -h; }
run_tcpdump() { sudo tcpdump -D; }
run_screen() { screen; }

# Tools arrays
COMMON_TOOLS=(
  nano neofetch git curl vim htop tree wget python3-pip yt-dlp neovim tmux ranger xclip
)
KALI_TOOLS=(
  nikto sqlmap hydra nmap msfconsole dirb john wfuzz dig ifconfig proxychains4 gobuster aircrack-ng
)
ADDITIONAL_TOOLS=(
  netcat tcpdump screen
)

run_tool() {
  local tool="$1"
  case "$tool" in
    nano) run_nano ;;
    neofetch) run_neofetch ;;
    git) run_git ;;
    curl) run_curl ;;
    vim) run_vim ;;
    htop) run_htop ;;
    tree) run_tree ;;
    wget) run_wget ;;
    python3-pip) run_python3_pip ;;
    yt-dlp) run_yt_dlp ;;
    neovim|nvim) run_neovim ;;
    tmux) run_tmux ;;
    ranger) run_ranger ;;
    xclip) run_xclip ;;
    nikto) run_nikto ;;
    sqlmap) run_sqlmap ;;
    hydra) run_hydra ;;
    nmap) run_nmap ;;
    msfconsole) run_msfconsole ;;
    dirb) run_dirb ;;
    john) run_john ;;
    wfuzz) run_wfuzz ;;
    dig) run_dnsutils ;;
    ifconfig) run_net_tools ;;
    proxychains4) run_proxychains4 ;;
    gobuster) run_gobuster ;;
    aircrack-ng) run_aircrack_ng ;;
    netcat) run_netcat ;;
    tcpdump) run_tcpdump ;;
    screen) run_screen ;;
    *) echo -e "${YELLOW}Unknown tool: $tool${RESET}" ;;
  esac
}

menu_prompt_with_name() {
  local prompt="$1"
  shift
  local options=("$@")

  while true; do
    clear
    echo -e "${GREEN}$prompt${RESET}"
    echo "----------------------------------"
    for i in "${!options[@]}"; do
      printf "%d) %s\n" $((i+1)) "${options[i]}"
    done
    echo "$(( ${#options[@]} + 1 ))) Back to Main Menu"
    echo
    read -rp $'\e[33mSelect by number or type tool name: \e[0m' input

    # Check if input is number in range
    if [[ "$input" =~ ^[0-9]+$ ]]; then
      if (( input >= 1 && input <= ${#options[@]} )); then
        run_tool "${options[input-1]}"
        read -rp $'\e[33mPress Enter to return to menu...\e[0m'
      elif (( input == ${#options[@]} + 1 )); then
        break
      else
        echo -e "${YELLOW}Invalid number, try again.${RESET}"
        sleep 1
      fi
    else
      # Try to match typed input with tool name (case insensitive)
      input_lower="${input,,}"  # lowercase
      found=0
      for tool in "${options[@]}"; do
        if [[ "${tool,,}" == "$input_lower" ]]; then
          run_tool "$tool"
          found=1
          read -rp $'\e[33mPress Enter to return to menu...\e[0m'
          break
        fi
      done
      if (( found == 1 )); then
        :
      elif [[ "$input_lower" == "back" ]]; then
        break
      else
        echo -e "${YELLOW}Invalid choice or tool name, try again.${RESET}"
        sleep 1
      fi
    fi
  done
}

common_menu() {
  while true; do
    menu_prompt_with_name "--- Common CLI Packages ---" "${COMMON_TOOLS[@]}"
    # Back returns here, so loop or exit handled in main menu
    break
  done
}

kali_menu() {
  while true; do
    menu_prompt_with_name "--- Kali Linux CLI Tools ---" "${KALI_TOOLS[@]}"
    break
  done
}

additional_menu() {
  while true; do
    menu_prompt_with_name "--- Additional CLI Tools ---" "${ADDITIONAL_TOOLS[@]}"
    break
  done
}

main_menu() {
  while true; do
    clear
    echo -e "${GREEN}=== Main Menu ===${RESET}"
    echo "1) Common CLI Packages"
    echo "2) Kali Linux CLI Tools"
    echo "3) Additional CLI Tools"
    echo "4) Exit"
    echo
    read -rp $'\e[33mSelect category: \e[0m' choice
    case $choice in
      1) common_menu ;;
      2) kali_menu ;;
      3) additional_menu ;;
      4) echo -e "${GREEN}Goodbye!${RESET}"; exit 0 ;;
      *) echo -e "${YELLOW}Invalid option.${RESET}"; sleep 1 ;;
    esac
  done
}

# Start menu after setup and updates
main_menu