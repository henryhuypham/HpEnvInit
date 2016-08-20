#! /bin/bash

# ---------- Utils ----------

is_command_exist() {
  command -v $1 > /dev/null
}

# ---------- Helpers ----------

install_if_not_exist() {
  echo '----------------------------------------------------------------'

  if $(is_command_exist $1); then
		echo "$(tput bold)$1$(tput sgr0) is already installed."
	else
		echo Installing $1 ...
		eval $2
		echo Done!
	fi
}

# ---------- Main Steps ----------

install_basic_tools() {
  # XCode Command Tools
  install_if_not_exist 'xcode-select' 'xcode-select --install'

  # HomeBrew
  install_if_not_exist 'brew' '/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"'

  # Fish Shell
  install_if_not_exist 'fish' 'brew install fish'
}

config_basic_tools() {
  # Fish Shell
  if ! $(is_command_exist 'fish'); then
    echo '/usr/local/bin/fish' | sudo tee -a /etc/shells
    chsh -s /usr/local/bin/fish
  fi
}

install_components() {
  echo '----------------------------------------------------------------'
  echo

  # Start installing components
  fish "$(dirname "${BASH_SOURCE[0]}")/install_components.fish"
}

# ---------- Exec Installations ----------

install_basic_tools
config_basic_tools
install_components
