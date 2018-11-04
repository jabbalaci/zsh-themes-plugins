# ----------------
# Jabba1 ZSH Theme
# ----------------
#
# Author: Laszlo Szathmary (Jabba Laci)
# https://github.com/jabbalaci/zsh-themes-plugins
#
# The digit '1' in the name of the theme refers to the fact
# that this theme produces 1 row.
# This is a simplified, shorter version of jabba2.
#

# dark / light colors
greenish="$FG[108]"
orange="$FG[208]"
lightblue="$FG[111]"
gray_darker="$FG[239]"
gray_lighter="$FG[244]"

time_dark="$fg_bold[green]"
time_light=$terminfo[bold]$gray_lighter

clean_dark="$fg_bold[green]"
clean_light="$terminfo[bold]$greenish"

venv_dark="$fg_bold[blue]"
venv_light="$fg_bold[blue]"

nim_bracket_dark="$fg_bold[blue]"
nim_bracket_light="$fg_bold[blue]"

nim_logo_dark="$fg_bold[yellow]"
nim_logo_light="$fg_bold[black]"

rprompt_dark=$gray_lighter
rprompt_light=$gray_darker

# prompt_char_dark="$terminfo[bold]$greenish"
# prompt_char_light="$terminfo[bold]$greenish"

branch_dark="$fg_bold[yellow]"
branch_light="$terminfo[bold]$greenish"

arrow_on_left_dark="$lightblue"
arrow_on_left_light="$gray_lighter"

pwd_dark="$fg_bold[magenta]"
pwd_light="$fg_bold[magenta]"

real_pwd_dark="$fg_bold[yellow]"
real_pwd_light="$terminfo[bold]$greenish"

dirty_dark="$fg_bold[red]"
dirty_light="$fg_bold[red]"

error_dark="$fg_bold[red]"
error_light="$fg_bold[red]"


if [[ "$JABBA_THEME_MODE" == "light" ]]; then
  cTime=$time_light
  cClean=$clean_light
  cVenv=$venv_light
  cNimBracket=$nim_bracket_light
  cNimLogo=$nim_logo_light
  cRprompt=$rprompt_light
  cPromptChar=$prompt_char_light
  cBranch=$branch_light
  cPwd=$pwd_light
  cRealPwd=$real_pwd_light
  cDirty=$dirty_light
  cError=$dirty_light
  cArrowOnLeft=$arrow_on_left_light
else
  cTime=$time_dark
  cClean=$clean_dark
  cVenv=$venv_dark
  cNimBracket=$nim_bracket_dark
  cNimLogo=$nim_logo_dark
  cRprompt=$rprompt_dark
  cPromptChar=$prompt_char_dark
  cBranch=$branch_dark
  cPwd=$pwd_dark
  cRealPwd=$real_pwd_dark
  cDirty=$dirty_dark
  cError=$dirty_dark
  cArrowOnLeft=$arrow_on_left_dark
fi

# https://stackoverflow.com/a/8811800/232485
_contains() {
    local string="$1"
    local substring="$2"
    if test "${string#*$substring}" != "$string"
    then
        return 1    # $substring is in $string
    else
        return 0    # $substring is not in $string
    fi
}

_hr() {
  echo $(seq -s= 78 | tr -d '[:digit:]')
}

ZSH_THEME_GIT_PROMPT_PREFIX=" $fg[white]« %{$cBranch%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} $fg[white]»%{$reset_color%}"

ZSH_THEME_GIT_PROMPT_DIRTY="%{$cDirty%} ✗%{$reset_color%}"    # _is_dirty() relies on the cross sign
ZSH_THEME_GIT_PROMPT_CLEAN="%{$cClean%} ✔%{$reset_color%}"

ZSH_THEME_VIRTUALENV_PREFIX="%{$cVenv%}["
ZSH_THEME_VIRTUALENV_SUFFIX="]%{$reset_color%} "

NIM_THEME_PREFIX="%{$cNimBracket%}[%{$cNimLogo%}"
NIM_THEME_SUFFIX="%{$cNimBracket%}]%{$reset_color%} "

_is_dirty() {
  local res=$(parse_git_dirty)
  if _contains $res  "✗"; then
    return 1
  else
    return 0
  fi
}

_branch_name() {
  local _=$(git_prompt_info)
  local name=$(git_current_branch)
  if [[ $name == "" ]]; then
    return
  fi

  if _is_dirty; then
    echo "%{$cDirty%} ($name)%{$reset_color%}"
  else
    echo "%{$cClean%} ($name)%{$reset_color%}"
  fi
}

# _my_prompt="λ"
_my_prompt="$"

_ret_status="%(?:%{$cPromptChar%}$_my_prompt%{$reset_color%}:%{$cError%}$_my_prompt%{$reset_color%})"

PROMPT=$'$(_hr)\n$(nim_project_info)$(virtualenv_prompt_info)%{$cTime%}[%D{%H:%M:%S}]%{$reset_color%} %{$cPwd%}%~%{$reset_color%}$(_branch_name) ${_ret_status} '

RPROMPT="%{$cRprompt%}[ oh-my-zsh ]%{$reset_color%}"
