# easier alias to use the plugin
alias ccat='colorize_via_pygmentize'
alias pcat='colorize_via_pygmentize'

colorize_via_pygmentize() {
    if ! (( $+commands[pygmentize] )); then
        echo "package 'Pygments' is not installed!"
        return 1
    fi

    # pygmentize stdin if no arguments passed
    if [ $# -eq 0 ]; then
        pygmentize -f terminal256 -O style=native -g
        return $?
    fi

    # guess lexer from file extension, or
    # guess it from file contents if unsuccessful
    local FNAME lexer
    for FNAME in $@
    do
        lexer=$(pygmentize -N "$FNAME")
        if [[ $lexer != text ]]; then
            pygmentize -f terminal256 -O style=native -l "$lexer" "$FNAME"
        else
            pygmentize -f terminal256 -O style=native -g "$FNAME"
        fi
    done
}
