zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# prompt stuff
autoload -Uz vcs_info

zstyle ':vcs_info:*' formats '%b'
zstyle ':vcs_info:*' actionformats '%b'

function precmd() {
	local venv_prefix=""
	if [[ -n "${VIRTUAL_ENV:-}" ]]; then
		venv_prefix="($(basename $VIRTUAL_ENV)) "
	fi
	if git rev-parse --is-inside-work-tree &>/dev/null; then
		vcs_info
		local dirty=""
		if [[ -n "$(git status --porcelain 2>/dev/null)" ]]; then
			dirty="*"
		fi
		PROMPT="${venv_prefix}%F{032}%~ %F{green}('${vcs_info_msg_0_}${dirty}') %f$ "
	else
		PROMPT="${venv_prefix}%F{032}%~ %f$ "
	fi
}
RPROMPT='%F{yellow}%n@%m%f %F{cyan}%D{%H:%M}%f'
setopt PROMPT_SUBST

# aliases
alias ls="ls -G"
alias ll="ls -l"
alias la="ls -a"
alias lla="ls -al"
alias c="clear"
alias dc="docker compose"
function dceb() {
	docker compose exec $1 bash
}

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$(brew --prefix nvm)/nvm.sh" ] && \. "$(brew --prefix nvm)/nvm.sh"
[ -s "$(brew --prefix nvm)/etc/bash_completion.d/nvm" ] && \. "$(brew --prefix nvm)/etc/bash_completion.d/nvm"

# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/michael/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions
