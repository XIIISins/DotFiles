setprompt() {
    local IT=${terminfo[sitm]}${terminfo[bold]}
    local ST=${terminfo[sgr0]}${terminfo[ritm]}
#    local FMT_BRANCH="%F{9}(%s:%F{7}%{$IT%}%r%{$ST%}%F{9}) %F{11}%B%b %K{235}%{$IT%}%u%c%{$ST%}%k
    local FMT_BRANCH="%F{9}(%s:%F{7}%{$IT%}%r%{$ST%}%F{9}) %F{11}%B%b %K{0}%{$IT%}%u%c%{$ST%}%k"
    local FMT_ACTION="(%F{3}%a%f)"
    local FMT_PATH="%F{1}%R%F{2}/%S%f"

    local RETURN="%(?..%F{9}%B!%b%f%F{1}%?%f )"
    local NAME="%F{4}%B%n%b%f"
    local HOST="%F{1}%B%m%b%f"
    local PATH="%F{8}[%F{3}%40<â€¦<%~%<<%F{8}]%f"
    local JOBS="%(1j.%K{1}%F{235}%B%j%b%f%k .)"
    local VIM=${${KEYMAP/vicmd/%K{2}%F{0} N %f%k }/(main|viins)/}

    local NEWLINE=$'\n'
    local DE=${DEBUG:+%F{9}DEBUG%f }
    local VENV=${VIRTUAL_ENV:+%F{3}VENV%f }
    PROMPT="${vcs_info_msg_0_}${NEWLINE}${VIM}${RETURN}${JOBS}${DE}${NAME}%F{8}@%f${HOST}${PATH}%B%#%b "
    RPROMPT=""
    PS2=%_

    # vcs_info
    zstyle ':vcs_info:*'                      enable git hg svn
    zstyle ':vcs_info:*' check-for-changes true
    zstyle ':vcs_info:*' unstagedstr '%F{62}D%F{237}IRTY%f'
    zstyle ':vcs_info:*' stagedstr '%F{62}S%F{237}TAGED'
    zstyle ':vcs_info:*' actionformats "${FMT_BRANCH}${FMT_ACTION}" "zsh: %r"
    zstyle ':vcs_info:*' formats       "${FMT_BRANCH}"              "zsh: %r"
    zstyle ':vcs_info:*' nvcsformats   ""                           "%~"
}

function zle-line-init zle-keymap-select {
    setprompt
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select
