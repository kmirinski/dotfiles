# -------------- ENVIRONMENT --------------

# Paths
ZSH_PLUGINS=~/.config/zsh

# Default Editor 
export EDITOR="nvim"

# HiDPI scaling fixes
# export GDK_SCALE=2
# export GDK_DPI_SCALE=1
# export GDK_BACKEND=wayland
# export QT_AUTO_SCREEN_SCALE_FACTOR=0
# export QT_SCALE_FACTOR=1
# export QT_ENABLE_HIGHDPI_SCALING=1
# export WINIT_X11_SCALE_FACTOR=1.5

# Fpath
fpath=("${ZSH_PLUGINS}/zsh-completions/src" $fpath)

# -------------- HISTORY SETTINGS --------------
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

setopt APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt SHARE_HISTORY


# -------------- ALIASES --------------
alias vim='nvim'
alias firefox='firefox &>/dev/null &'

# -------------- PLUGINS --------------
if [[ -f "${ZSH_PLUGINS}/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
  source "${ZSH_PLUGINS}/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

if [[ -f "${ZSH_PLUGINS}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
  source "${ZSH_PLUGINS}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

#if [[ -f "${ZSH_PLUGINS}/zsh-completions/src" ]]; then
#  source "${ZSH_PLUGINS}/zsh-completions/src"
#fi

if [[ -f "${ZSH_PLUGINS}/powerlevel10k/powerlevel10k.zsh-theme" ]]; then
  source "${ZSH_PLUGINS}/powerlevel10k/powerlevel10k.zsh-theme"
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# -------------- PLUGINS --------------
bindkey "^[[1;5D" backward-word   # Ctrl + Left
bindkey "^[[1;5C" forward-word    # Ctrl + Right

# -------------- OPTIONS --------------

# Enable completions
autoload -Uz compinit; compinit	

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="$HOME/.local/bin:$PATH"
