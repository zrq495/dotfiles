function change_ps1 (){
    local black="\[\e[0;30m\]"
    local red="\[\e[0;31m\]"
    local green="\[\e[0;32m\]"
    local yellow="\[\e[0;33m\]"
    local blue="\[\e[0;34m\]"
    local magenta="\[\e[0;35m\]"
    local cyan="\[\e[0;36m\]"
    local white="\[\e[0;37m\]"
    local normal="\[\e[0;m\]"

    local dir=. head
    local git_branch=""
    local hg_branch=""

    until [ "$dir" -ef / ]; do
        if [ -f "$dir/.git/HEAD" ]; then
            local head=$(< "$dir/.git/HEAD")
            if [[ $head = ref:\ refs/heads/* ]]; then
                git_branch=" → ${head#*/*/}"
            elif [[ $head != '' ]]; then
                git_branch=" → (detached)"
            else
                git_branch=" → (unknow)"
            fi
            break
        fi

        if [ -f "$dir/.git" ]; then
            local head=$(< "$dir/$(cat $dir/.git|awk '{print $2}')/HEAD")
            if [[ $head = ref:\ refs/heads/* ]]; then
                git_branch=" → ${head#*/*/}"
            elif [[ $head != '' ]]; then
                git_branch=" → (detached)"
            else
                git_branch=" → (unknow)"
            fi
            break
        fi
        
        if [ -d "$dir/.hg" ]; then
            hg_branch=" → $(cat $dir/.hg/branch)"
            break 
        fi
        dir="../$dir"
    done

    local virtual_env=""
    if [ $VIRTUAL_ENV ]; then
        virtual_env=$(echo "$VIRTUAL_ENV" | awk -v FS="/" '{print $NF}')
        virtual_env="($virtual_env)"
    fi

    # export PS1="$virtual_env$white\A $normal\u@$blue\h$normal:$yellow\w$red$git_branch$hg_branch $normal$ "
    export PS1="$virtual_env$white\A $yellow\w$red$git_branch$hg_branch $normal"
}
export PROMPT_COMMAND="change_ps1; $PROMPT_COMMAND"

export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

export CLICOLOR=1

if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
    source /usr/local/bin/virtualenvwrapper.sh
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

