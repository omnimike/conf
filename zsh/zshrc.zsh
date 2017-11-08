# Expire duplicate entries first when trimming history.
setopt HIST_EXPIRE_DUPS_FIRST
# Dont record an entry that was just recorded again.
setopt HIST_IGNORE_DUPS
# Delete old recorded entry if new entry is a duplicate.
setopt HIST_IGNORE_ALL_DUPS
# Dont record an entry starting with a space.
setopt HIST_IGNORE_SPACE
# Dont write duplicate entries in the history file.
setopt HIST_SAVE_NO_DUPS
# Remove superfluous blanks before recording entry.
setopt HIST_REDUCE_BLANKS

# alias
alias e='nvim'
alias r='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'
alias j='jump'
alias vg='vagrant'
alias gpb='git push origin $(git_current_branch)'
alias gpbf='git push origin $(git_current_branch) -f'

alias zshrc="e ~/.zshrc"
alias zshenv="e ~/.zshenv"
alias zshreload="source ~/.zshrc"
alias vimrc="e ~/.vimrc"

ZSH_THEME=""

# plugins
source ~/conf/zsh/antigen.zsh

antigen use oh-my-zsh

# oh-my-zsh plugins
antigen bundle git
antigen bundle vagrant

# other plugins
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle jocelynmallon/zshmarks
antigen bundle mafredri/zsh-async
antigen bundle sindresorhus/pure

antigen apply

# vim keybindings
bindkey -v
bindkey '^p' up-history
bindkey '^n' down-history

if [ -e ~/.zshrc-local ]; then
    source ~/.zshrc-local
fi

# Custom functions
# fd - cd to selected directory
fd() {
  local dir
  dir=$(find ${1:-*} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

# fda - including hidden directories
fda() {
  local dir
  dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m) && cd "$dir"
}

# fe - edit file
fe() {
    local file
    file=$(fzf +m) || return
    e $file
}

# fco - checkout git branch/tag
fco() {
  local tags branches target
  tags=$(
    git tag | awk '{print "\x1b[31;1mtag\x1b[m\t" $1}') || return
  branches=$(
    git branch --all | grep -v HEAD             |
    sed "s/.* //"    | sed "s#remotes/[^/]*/##" |
    sort -u          | awk '{print "\x1b[34;1mbranch\x1b[m\t" $1}') || return
  target=$(
    (echo "$tags"; echo "$branches") |
    fzf --no-hscroll --ansi +m -d "\t" -n 2) || return
  git checkout $(echo "$target" | awk '{print $2}')
}

# fh - repeat history
fh() {
  print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh