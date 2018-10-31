function nim_project_info() {
  for file in $(find . -maxdepth 1 -name '*.nimble'); do
    if [ -f $file ]; then
        echo "${NIM_THEME_PREFIX:=[}♛${NIM_THEME_SUFFIX:=]}"
        break
    fi
  done
}
