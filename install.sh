#!/bin/sh

# Install all dotfiles
dotfiles=(.vimrc .zshrc)

for dotfile in ${dotfiles[*]}; do
	printf "Installing %s...\n" $dotfile
	ln -s `pwd`/$dotfile ~/$dotfile 2> /dev/null
done

# Setting up Oh My Zsh theme
if [ ! -d ~/.oh-my-zsh ]; then
	echo "Installing Oh My Zsh..."
	sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

if [ ! -f ~/.oh-my-zsh/themes/honukai.zsh-theme ]; then
	echo "Downloading honukai theme for Oh My Zsh..."
	curl -LSso ~/.oh-my-zsh/themes/honukai.zsh-theme https://raw.githubusercontent.com/oskarkrawczyk/honukai-iterm-zsh/master/honukai.zsh-theme
fi

# Setting up ViM theme and plugin
mkdir -p ~/.vim/autoload ~/.vim/bundle

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
