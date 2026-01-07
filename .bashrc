# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

PS1='\[\e[1;49;94m\]〘vox〙\[\e[1;49;94m\]|\[\e[0m\e[0;49;92m\]\w\[\e[0m\]\[\e[1;49;94m\]|\n\[\e[1;49;94m\]\[\e[0m\]\[\e[0;49;92m\] *\[\e[0m\] '

# clean first
rm -rf .cache

# alias del="rm -rf"
alias cp="cp -r"
alias add="sudo dnf install"
# alias pxadd='sudo dnf --setopt=proxy=http://192.168.49.1:9099 install "$@"'
alias rem="sudo dnf remove"
alias search="dnf search"
alias info="dnf info"
alias clean="sudo dnf clean all && sudo dnf autoremove"
alias cd..="cd .."
alias mkdir="mkdir -p"
alias nano="nano -E -L -P -T 2 -U -i -l -m -q -x -% -0 -/"
alias uz="trans :uz -b"
alias en="trans :en -b"
alias ru="trans :ru -b"
alias ko="trans :ko -b"
alias ls="ls -t --color"
alias lsa="ls -A"
alias l="ls -lhA"
alias staticCompile="gcc -Os -flto -ffunction-sections -fdata-sections -Wl,--gc-sections -fno-builtin"
alias x="exit"
alias w="pwd"
# alias mc="micro"
alias open="xdg-open"
alias chmod="sudo chmod"
alias clear="clear && ls"
alias sc="grep -rni"
alias keyd="mc /etc/keyd/default.conf && systemctl restart keyd"

# clear
alias c="clear"
alias cler="clear"
alias clare="clear"
alias clre="clear"
alias clar="clear"
alias clea="clear"
alias claer="clear"
alias clae="clear"
alias clr="clear"
clear

# home permissions
# sudo chown -R $USER:$USER /home/$USER

# Enable basic completion for all commands
if type _longopt &>/dev/null; then
  complete -o default -o nospace -F _longopt $(compgen -c)
fi


export GOTELEMETRY=off
