#!/bin/bash

# Get current dir (so run this script from anywhere)
export DOTFILES_DIR
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

dotfiles=(.vimrc .zshrc)

# Install all dotfiles
for dotfile in "${dotfiles[@]}"; do
	echo "Installing $DOTFILES_DIR/$dotfile..."
	ln -s $DOTFILES_DIR/$dotfile ~/$dotfile 2> /dev/null
done

# Setting up ViM theme and plugin
mkdir -p ~/.vim/autoload ~/.vim/bundle ~/.vim/colors

if [ ! -f ~/.vim/autoload/pathogen.vim ]; then
	echo "Installing Pathogen for ViM..."
	curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
fi

if [ ! -d ~/.vim/bundle/vim-colors-solarized ]; then
	cd ~/.vim/bundle
	echo "Downloading solarized theme for ViM..."
	git clone https://github.com/altercation/vim-colors-solarized
fi

if [ ! -d ~/.vim/bundle/syntastic ]; then
    cd ~/.vim/bundle
    echo "Downloading Syntastic for ViM..."
    git clone https://github.com/scrooloose/syntastic
fi

if [ ! -d ~/.vim/bundle/vim-jinja ]; then
    cd ~/.vim/bundle
    echo "Downloading Jinja for ViM..."
    git clone https://github.com/vlad003/vim-jinja
fi

if [ ! -d ~/.vim/bundle/vim-jdaddy ]; then
    cd ~/.vim/bundle
    echo "Downloading jDaddy for ViM..."
    git clone https://github.com/tpope/vim-jdaddy
fi

if [ ! -d ~/.vim/bundle/html5.vim ]; then
    cd ~/.vim/bundle
    echo "Downloading HTML5 for ViM..."
    git clone https://github.com/othree/html5.vim
fi

if [ ! -d ~/.vim/bundle/vim-javascript ]; then
    cd ~/.vim/bundle
    echo "Downloading Javascript for ViM..."
    git clone https://github.com/pangloss/vim-javascript
fi

# Setting up Oh My Zsh theme
if [ ! -d ~/.oh-my-zsh ]; then
	echo "Installing Oh My Zsh..."
	sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

if [ ! -f ~/.oh-my-zsh/themes/honukai.zsh-theme ]; then
	echo "Downloading honukai theme for Oh My Zsh..."
	curl -LSso ~/.oh-my-zsh/themes/honukai.zsh-theme https://raw.githubusercontent.com/oskarkrawczyk/honukai-iterm-zsh/master/honukai.zsh-theme
fi

# Get custom config back
if [ -f ~/.zshrc.pre-oh-my-zsh ]; then
    rm -v ~/${dotfiles[1]}
    mv -v ~/.zshrc.pre-oh-my-zsh ~/${dotfiles[1]}
fi

# Change Shell
if [ "$SHELL" != "$(which zsh)" ]; then
    chsh -s "$(which zsh)"
    echo "Logout to apply new shell"
fi
