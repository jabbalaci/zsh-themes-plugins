# Jabba Laci's MS-DOS prompt for zsh

TEXT1=`cat <<EOF
Starting MS-DOS...
EOF
`

TEXT2=`cat <<EOF
Microsoft Windows [Version 6.2.9200]
(c) 2012 Microsoft Corporation. All rights reserved.
EOF
`

echo ${TEXT2}
echo

_fishy_collapsed_wd() {
  echo $(pwd | perl -pe '
   BEGIN {
      binmode STDIN,  ":encoding(UTF-8)";
      binmode STDOUT, ":encoding(UTF-8)";
   }; s|/([^/.])[^/]*(?=/)|/$1|g; s|/\.([^/])[^/]*(?=/)|/.$1|g
')
}

_msdos_pwd() {
  # echo $(_fishy_collapsed_wd) | tr '/' '\\'
  echo $(pwd) | sed -e "s|^/home/|/Users/|" | tr '/' '\\'
}

PROMPT=$'\nC:`_msdos_pwd`> '
