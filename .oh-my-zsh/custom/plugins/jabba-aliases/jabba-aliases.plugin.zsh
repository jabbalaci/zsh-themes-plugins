# Opens the github page for the current git repository in your browser
# git@github.com:jasonneylon/dotfiles.git
# https://github.com/jasonneylon/dotfiles/
function gh() {
  giturl=$(git config --get remote.origin.url)
  if [[ "$giturl" == "" ]]; then
    echo "Not a git repository or no remote.origin.url set"
    exit 1
  fi

  giturl=${giturl/git\@github\.com\:/https://github.com/}
  giturl=${giturl/\.git/\/tree/}
  branch="$(git symbolic-ref HEAD 2>/dev/null)" ||
  branch="(unnamed branch)"     # detached HEAD
  branch=${branch##refs/heads/}
  giturl=${giturl}${branch}
  echo "#" $giturl
  xdg-open $giturl
}

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias vi=$EDITOR
alias vim=$EDITOR
alias d='ls -al'
alias ll='dirs -v | head -10'
alias mc='. /usr/lib/mc/mc-wrapper.sh'
alias p2='python2'
alias p3='python3'
alias p='python3'
alias ipy='ipython'
alias ed='code .'
alias ppwd='/bin/pwd'
alias r='ranger'
alias n='nnn'
alias sagi='sudo apt install'    # used to be `sudo apt-get install`
alias run='chmod u+x'
alias ez="$EDITOR $HOME/.zshrc"    # edit ~/.zshrc
