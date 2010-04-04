function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)]/"
}
export PS1='\u@\h \[\033[1;33m\]\w\[\033[0m\]$(parse_git_branch)$ '

alias ls='ls -Gpx'

# ruby
alias irb='irb --readline -r irb/completion --simple-prompt'
 
# rails
alias sc='ruby script/console'
alias ss='ruby script/server'
alias sg='ruby script/generate'

if [[ -s /Users/fitz/.rvm/scripts/rvm ]] ; then source /Users/fitz/.rvm/scripts/rvm ; fi
