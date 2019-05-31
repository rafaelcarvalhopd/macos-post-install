#!/bin/bash

dir="$(dirname "$0")"

RUBY_VERSION=2.5.3
BUNDLER_VERSION=1.17.3
COCOAPODS_VERSION=1.7.0

# SHOW FUNCTIONS

show_info() {
    echo -e "\033[1;33m$@\033[0m" 
}

show_success() {
    echo -e "\033[1;32m$@\033[0m"
}

show_error() {
    echo -e "\033[1;31m$@\033[m" 1>&2
}

function show_current_versions {
    echo ""
    echo "----------------------------------------"
    show_info "Showing all current versions:"
    xcode-select -v
    echo ""
    brew -v
    echo ""
    rbenv -v
    echo ""
    ruby -v
    echo ""
    bundle -v
    echo ""
    echo "CocoaPods $(pod --version)"
    echo "----------------------------------------"
    echo ""
}


# INSTALL FUNCTIONS

function install_xcode_command_line {
    echo ''
    show_info 'Installing Xcode Command Line Tools...'
    xcode-select --install
    echo "Done."
}

function install_homebrew {
    echo ''
    show_info 'Installing Homebrew...'
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    echo "Done."
}

function install_oh_my_zsh {
    echo ''
    show_info 'Installing Oh-My-Zsh...'
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    echo "Done."
}

function install_rbenv {
    echo ''
    show_info 'Installing Ruby Version Manager (rbenv)...'
    brew install rbenv
    rbenv install $RUBY_VERSION
    echo 'Setting rbenv global version...'
    sudo rbenv global $RUBY_VERSION

    echo "" >> ~/.zshrc
    echo "" >> ~/.zshrc
    grep -qxF '# rbenv (ruby)' ~/.zshrc || echo '# rbenv (ruby)' >> ~/.zshrc
    grep -qxF 'export PATH="$HOME/.rbenv/shims:$PATH"' ~/.zshrc || echo 'export PATH="$HOME/.rbenv/shims:$PATH"' >> ~/.zshrc
    grep -qxF 'export PATH="$HOME/.rbenv/bin:$PATH"' ~/.zshrc || echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.zshrc
    grep -qxF 'eval "$(rbenv init -)"' ~/.zshrc || echo 'eval "$(rbenv init -)"' >> ~/.zshrc

    export PATH="$HOME/.rbenv/shims:$PATH"
    export PATH="$HOME/.rbenv/bin:$PATH"
    eval "$(rbenv init -)"
    echo "Done."
}

function install_bundler {
    echo ''
    show_info 'Installing Bundler...'
    gem install bundler -v $BUNDLER_VERSION
    echo "Done."
}

function install_cocoapods {
    echo ''
    show_info 'Installing CocoaPods...'
    gem install cocoapods -v $COCOAPODS_VERSION
    echo "Done."
}

function install_use_keychain_for_ssh {
    echo ''
    show_info 'Setting UseKeychain for SSH login...'
    grep -qxF 'Host *' ~/.ssh/config || echo 'Host *' >> ~/.ssh/config
    grep -qxF '  AddKeysToAgent yes' ~/.ssh/config || echo '
  AddKeysToAgent yes' >> ~/.ssh/config
    echo "Done."
}

function install_faster_dock {
    echo ''
    show_info 'Installing Faster Dock...'
    defaults write com.apple.dock autohide-delay -float 0
    defaults write com.apple.dock autohide-time-modifier -float 0.5
    killall Dock
    echo "Done."
}

function install_slack {
    echo ''
    show_info 'Installing Slack...'
    brew cask install slack
    echo "Done."
}

function install_all {
    install_xcode_command_line
    install_homebrew
    install_oh_my_zsh
    install_rbenv
    install_bundler
    install_cocoapods
    install_use_keychain_for_ssh
    install_faster_dock
    install_slack
}


# UNINSTALL FUNCTIONS

function uninstall_xcode_command_line {
    echo ''
    show_info 'Uninstalling Xcode Command Line Tools...'
    echo "Done."
}

function uninstall_homebrew {
    echo ''
    show_info 'Uninstalling Homebrew...'
    echo "Done."
}

function uninstall_oh_my_zsh {
    echo ''
    show_info 'Uninstalling Oh-My-Zsh...'
    echo "Done."
}

function uninstall_rbenv {
    echo ''
    show_info 'Uninstalling Ruby Version Manager (rbenv)...'
    echo "Done."
}

function uninstall_bundler {
    echo ''
    show_info 'Uninstalling Bundler...'
    echo "Done."
}

function uninstall_cocoapods {
    echo ''
    show_info 'Uninstalling CocoaPods...'
    yes | gem uninstall cocoapods
    echo "Done."
}

function uninstall_use_keychain_for_ssh {
    echo ''
    show_info 'Uninstalling UseKeychain for SSH login...'
    echo "Done."
}

function uninstall_faster_dock {
    echo ''
    show_info 'Uninstalling Faster Dock...'
    defaults write com.apple.dock autohide-delay -float 0.5
    defaults write com.apple.dock autohide-time-modifier -float 1.0
    killall Dock
    echo "Done."
}

function uninstall_slack {
    echo ''
    show_info 'Uninstalling Slack...'
    killall Slack
    brew cask uninstall slack --force
    rm -rf /Applications/Slack.app
    rm -rf ~/Library/Application\ Support/Slack/
    rm -rf ~/Library/Containers/com.tinyspeck.slackmacgap/
    rm -rf ~/Library/Preferences/com.tinyspeck.slackmacgap.plist
    rm -rf ~/Library/Saved\ Application\ State/com.tinyspeck.slackmacgap.savedState 
    echo "Done."
}

function uninstall_all {
    uninstall_xcode_command_line
    uninstall_homebrew
    uninstall_oh_my_zsh
    uninstall_rbenv
    uninstall_bundler
    uninstall_cocoapods
    uninstall_use_keychain_for_ssh
    uninstall_faster_dock
    uninstall_slack
}

# OPTIONS FUNCTIONS

function case_install {
    show_info 'Enter your choice:' && read REPLY
    case $REPLY in
    1) # All Tools
        install_all
    ;;
    2) # Xcode Command Line Tools
        install_xcode_command_line
    ;;
    3) # Homebrew
        install_homebrew
    ;;
    4) # Oh-My-Zsh
        install_oh_my_zsh
    ;;
    5) # Ruby Version Manager (rbenv)
        install_rbenv
    ;;
    6) # Bundler
        install_bundler
    ;;
    7) # CocoaPods
        install_cocoapods
    ;;
    8) # UseKeychain for SSH login
        install_use_keychain_for_ssh
    ;;
    9) # Faster Dock
        install_faster_dock
    ;;
    10) # Slack
        install_slack
    ;;
    0) # Exit
        exit 0
    ;;
    *) # Invalid option
        show_error "Invalid option."
        case_install
    ;;
    esac
}

function case_uninstall {
    show_error 'Enter your choice:' && read REPLY
    case $REPLY in
    1) # All Tools
        #install_all
    ;;
    2) # Xcode Command Line Tools
        #install_xcode_command_line
    ;;
    3) # Homebrew
        #install_homebrew
    ;;
    4) # Oh-My-Zsh
        #install_oh_my_zsh
    ;;
    5) # Ruby Version Manager (rbenv)
        #install_rbenv
    ;;
    6) # Bundler
        #install_bundler
    ;;
    7) # CocoaPods
        #install_cocoapods
    ;;
    9) # Faster Dock
        uninstall_faster_dock
    ;;
    10) # Slack
        uninstall_slack
    ;;
    0) # Exit
        exit 0
    ;;
    *) # Invalid option
        show_error "Invalid option."
        case_uninstall
    ;;
    esac
}

function case_main {
    show_info 'Enter your choice:' && read REPLY
    case $REPLY in
    1) # Install Tools
        install
    ;;
    2) # Uninstall Tools
        uninstall
    ;;
    3) # Tools Versions
        show_current_versions
    ;;
    0) # Exit
        exit 0
    ;;
    *) # Invalid option
        show_error "Invalid option."
        case_main
    ;;
    esac            
}

# MAIN FUNCTIONS
function install {
    clear
    show_info 'What would you like to install?'
    echo '-----------------------------------------'
    echo '| 1.  All Tools                         |'
    echo '| 2.  Xcode Command Line Tools          |'
    echo '| 3.  Homebrew                          |'
    echo '| 4.  Oh-My-Zsh                         |'
    echo '| 5.  Ruby Version Manager (rbenv)      |'
    echo '| 6.  Bundler                           |'
    echo '| 7.  CocoaPods                         |'
    echo '| 8.  UseKeychain for SSH login         |'
    echo '| 9.  Faster Dock                       |'
    echo '| 10. Slack                             |'
    echo '| 0.  Exit                              |'
    echo '-----------------------------------------'
    echo ''

    case_install

    echo ""
    show_success 'Installations done.'
}

function uninstall {  
    clear
    show_error 'What would you like to uninstall?'
    echo '-----------------------------------------'
    echo '| 1.  All Tools                         |'
    echo '| 2.  Xcode Command Line Tools          |'
    echo '| 3.  Homebrew                          |'
    echo '| 4.  Oh-My-Zsh                         |'
    echo '| 5.  Ruby Version Manager (rbenv)      |'
    echo '| 6.  Bundler                           |'
    echo '| 7.  CocoaPods                         |'
    echo '| 9.  Faster Dock                       |'
    echo '| 10. Slack                             |'
    echo '| 0.  Exit                              |'
    echo '-----------------------------------------'
    echo ''

    case_uninstall

    echo ""
    show_success 'Uninstallations done.'
}

function main {
    clear
    show_info 'What would you like to do?'
    echo '----------------------------------------'
    echo '| 1. Install Tools                     |'
    echo '| 2. Uninstall Tools                   |'
    echo '| 3. Show all tools versions           |'
    echo '| 0. Exit                              |'
    echo '----------------------------------------'
    echo ''

    case_main
}

main