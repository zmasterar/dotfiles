# https://github.com/copiousfreetime/launchy/issues/117#issuecomment-805730312
export BROWSER='wslopen'

# https://github.com/microsoft/WSL/issues/5065#issuecomment-682198412
fix_wsl2_interop() {
    for i in $(pstree -np -s $$ | grep -o -E '[0-9]+'); do
        if [[ -e "/run/WSL/${i}_interop" ]]; then
            export WSL_INTEROP=/run/WSL/${i}_interop
        fi
    done
}