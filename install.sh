#!/usr/bin/env bash

set -e
set -u
set -o pipefail

CURRENT_DIR="$(pwd -P)"
CLONE_URL="https://git.envs.net/lfdev/yadm-install.git"
CLONE_DIR="${1:-${CURRENT_DIR}}"
BIN_DIR="${HOME}/bin"
MAN_DIR="${HOME}/.local/share/man/man1"
CREATE_DIR=false

is_app_installed() {
    type "${1}" &>/dev/null
}

confirm_prompt() {
    read -p "${1} (y/N)? " response
    case "$response" in
        [yY])
            # comtinue
            ;;
        *)
            exit 0
            ;;
    esac
}

transform_path() {
  if [[ "$1" == "/"* ]]; then
    printf "${1}/yadm"
  else
    printf "${CURRENT_DIR}/${1}/yadm"
  fi
}

if ! is_app_installed git; then
    printf "ERROR: \"git\" not found\!\n"
    printf "       Please install it first.\n"
    exit 1
fi

CLONE_DIR="$(transform_path ${CLONE_DIR})"

if [ -e "${CLONE_DIR}" ]; then
    printf "${CLONE_DIR} exists, it will cause an error if not empty.\n"
else
    printf "${CLONE_DIR} does not exist, it will be created.\n"
    CREATE_DIR=true
fi

confirm_prompt "Continue"
[ "${CREATE_DIR}" ] && mkdir -p "${CLONE_DIR}"

git clone --single-branch --branch master --depth=1 "${CLONE_URL}" "${CLONE_DIR}"

CREATE_DIR=false

if [ ! -e "${BIN_DIR}" ]; then
    BIN_DIR="${HOME}/.local/bin"
    CREATE_DIR=true
fi

[ "${CREATE_DIR}" ] && mkdir -p "${BIN_DIR}"
ln -sf "${CLONE_DIR}/yadm" "${BIN_DIR}/"
mkdir -p "${MAN_DIR}" && ln -sf "${CLONE_DIR}/yadm.1" "${MAN_DIR}/"

printf "yadm executable was simlinked to ${BIN_DIR}\n"
printf "Make sure it is in the \$PATH.\n"

confirm_prompt "Do you want to clone your dotfiles repo now"

printf "Please type your dotfiles repo address and press ENTER:\n"
read -p "> " dot_repo
[ ! -z "$dot_repo" ] && "${CLONE_DIR}"/yadm clone "${dot_repo}"
