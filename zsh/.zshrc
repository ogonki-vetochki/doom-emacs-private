# new user install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# End of lines configured by zsh-newuser-install

# com-install
zstyle ':completion:*' completer _complete _ignored
zstyle :compinstall filename '/Users/ogonki-vetochki/.zshrc'

autoload -Uz compinit
compinit

# Antibody config
source <(antibody init)

antibody bundle zsh-users/zsh-completions
antibody bundle robbyrussell/oh-my-zsh path:plugins/colored-man-pages
antibody bundle robbyrussell/oh-my-zsh path:plugins/git
antibody bundle bhilburn/powerlevel9k
antibody bundle zsh-users/zsh-syntax-highlighting
antibody bundle zsh-users/zsh-autosuggestions
antibody bundle hlissner/zsh-autopair

# ENV variables
export LANG=en_US
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export PATH="$HOME/.emacs.d/bin:$PATH"
export ROSWELL_HOME="$HOME/.config/roswell"
