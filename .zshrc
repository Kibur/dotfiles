# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Zsh autosuggestions
#source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
#ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#ff00ff,bg=cyan,bold,underline"

# Alias definition.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# kitty
export PATH=$PATH:~/.local/kitty.app/bin

# Additional (kitty) IMPORTANT might conflict with tmux!
# Will automatically copy the terminfo files to the server.
# This ssh kitten take all the same command line arguments as ssh.
#alias ssh="kitty +kitten ssh"

# Binds fixing control key + arrows
bindkey "\e[1;5C" forward-word
bindkey "\e[1;5D" backward-word
