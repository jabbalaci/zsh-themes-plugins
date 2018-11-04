# activate the virt. env. if Pipfile exists
_activate_venv() {
  if [[ -n ${VIRTUAL_ENV} ]]; then
      # echo "# virt. env. is already activated"
      return
  fi
  # else
  if [[ -f Pipfile ]]; then
    # echo "# activating venv…"
    source $(pipenv --venv)/bin/activate
  fi
}

autoload -U add-zsh-hook
add-zsh-hook chpwd _activate_venv

_activate_venv


alias off='deactivate'
