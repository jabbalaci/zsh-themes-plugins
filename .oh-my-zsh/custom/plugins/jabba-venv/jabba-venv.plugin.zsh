# activate the virt. env. if Pipfile exists
_activate_venv() {
  if [[ "$PIPENV_ACTIVE" != 1 ]]; then
    if [[ -f Pipfile ]]; then
      # echo "# activating venv…"
      source $(pipenv --venv)/bin/activate
    fi
  fi
}

autoload -U add-zsh-hook
add-zsh-hook chpwd _activate_venv

_activate_venv


alias off='deactivate'
