
# Configure system PATH
export PATH="${PATH}:/usr/local/go/bin:${HOME}/go/bin"
export PATH="${PATH}:${HOME}/bin"
export PATH="${PATH}:${HOME}/.tfenv/bin"
export GOPATH="${HOME}/go"

# Include GPG
export GPG_TTY=$(tty)

# Configure system editor
export EDITOR="nvim"
export VISUAL="nvim"

# Standard Manjaro Zsh Configuration
export USE_POWERLINE="true"
if [[ -r ${MANJARO_ZSH_CONFIG:=/usr/share/zsh/manjaro-zsh-config} ]]; then
	source ${MANJARO_ZSH_CONFIG}
fi

if [[ -r ${MANJARO_ZSH_PROMPT:=/usr/share/zsh/manjaro-zsh-prompt} ]]; then
	source ${MANJARO_ZSH_PROMPT}
fi

# Import custom aliases and functions
if [[ -r ${ALIASES:-$HOME/.aliasrc} ]]; then
	source ${ALIASES:-$HOME/.aliasrc}
fi

# Import secrets
if [[ -r ${ENV_SECRETS:-$HOME/.env/secrets} ]]; then
	source ${ENV_SECRETS:-$HOME/.env/secrets}
fi

# Load fzf for hotkey functionality
if [[ -r ${FZF_ZSH:-~/.fzf.zsh} ]]; then
	source ${FZF_ZSH:-~/.fzf.zsh}
fi

# Load nvm binary
export NVM_DIR="${HOME}/.nvm"
[ -s "${NVM_DIR}/nvm.sh" ] && \. "${NVM_DIR}/nvm.sh" # Load nvm
[ -s "${NVM_DIR}/bash_completion" ] && \. "${NVM_DIR}/bash_completion" # Load nvm bash completion

