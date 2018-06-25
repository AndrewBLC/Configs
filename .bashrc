#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'

alias open='xdg-open'
alias i3conf='$EDITOR ~/.config/i3/config'
alias vimconf='$EDITOR ~/.vimrc'
alias tmuxconf='$EDITOR ~/.tmux.conf'
alias bashconf='$EDITOR ~/.bashrc'
alias sshman='ssh mbaxaab3@kilburn.cs.man.ac.uk'

# >>> Added by cnchi installer
EDITOR=/usr/bin/vim
TERMINAL=gnome-terminal

#compton -fb --config ~/.config/compton.conf
export QT_SCALE_FACTOR=1
export PATH=$PATH:/home/$USER/.bin

########################################################
# setup prompt
########################################################
# get current branch in git repo
function parse_git_branch() {
    BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
    if [ ! "${BRANCH}" == ""  ]
    then
        STAT=`parse_git_dirty`
        echo "[${BRANCH}${STAT}]"
    else
        echo ""
    fi
}

# get current status of git repo
function parse_git_dirty {
    status=`git status 2>&1 | tee`
    dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
    untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
    ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
    newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
    renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
    deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
    bits=''
    if [ "${renamed}" == "0"  ]; then
        bits=">${bits}"
    fi
    if [ "${ahead}" == "0"  ]; then
        bits="*${bits}"
    fi
    if [ "${newfile}" == "0"  ]; then
        bits="+${bits}"
    fi
    if [ "${untracked}" == "0"  ]; then
        bits="?${bits}"
    fi
    if [ "${deleted}" == "0"  ]; then
        bits="x${bits}"
    fi
    if [ "${dirty}" == "0"  ]; then
        bits="!${bits}"
    fi
    if [ ! "${bits}" == ""  ]; then
        echo " ${bits}"
    else
        echo ""
    fi
}

PS1="\[\e[37m\]\u\[\e[m\]: \[\e[33m\]\w\[\e[m\] \[\e[31m\]\`parse_git_branch\`\[\e[m\]\\$ "
