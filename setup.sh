#!/bin/bash

RUBY_VERSION="2.1.1"

if [ -f /usr/local/bin/brew ]
  then
    echo "Homebrew exists. Skipping installation"
  else
    ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"   
    brew doctor
fi

brew install git

brew install rbenv
brew install ruby-build
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
rbenv install $RUBY_VERSION
rbenv global $RUBY_VERSION

brew install fish
read -p 'Set oh-my-fish as shell?' setFishShell
case $setFishShell in
  [Yy]* ) 
    curl -L https://github.com/bpinto/oh-my-fish/raw/master/tools/install.fish | fish;
    grep -q '^/usr/local/bin/fish$' /etc/shells; or echo '/usr/local/bin/fish' | sudo tee -a /etc/shells;
    chsh -s /usr/local/bin/fish;
    break;;
  * ) echo Skipping shell change;;
esac

brew install tmux
brew install reattach-to-user-namespace

brew install npm
npm_install_or_update () 
{
  version=$(npm list -g -depth=0 | grep $1 | cut -d @ -f 2)
  if [[ -n $version ]]
  then
    echo Found $1 with version $version. Updating…
    npm update -g $1
  else
    echo $1 not found. Installing…
    npm install -g $1
  fi
}

npm_install_or_update grunt-cli
npm_install_or_update bower
npm_install_or_update typescript
npm_install_or_update typescript-tools
npm_install_or_update gulp
npm_install_or_update gulp-tsc
npm_install_or_update gulp-handlebars



