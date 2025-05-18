#!/bin/bash
#
# Download, verify, build and install a given Python version.
# Usage: install_python.sh [PYTHON VERSION]
#
# make altinstall is used for installation, which means the binary has a
# version suffix (a typical binary would be /usr/local/bin/pythonX.Y).
#

set -eo pipefail

err() {
  echo "ERROR: $*" >&2
}

install_dependencies() {
  echo "Attempting to install dependencies (Ubuntu/Debian)"
  set +e
  sudo apt-get update -qq
  # See https://github.com/python/cpython/blob/main/.github/workflows/posix-deps-apt.sh
  sudo apt-get -qq install \
    build-essential \
    pkg-config \
    ccache \
    gdb \
    lcov \
    libb2-dev \
    libbz2-dev \
    libffi-dev \
    libgdbm-dev \
    libgdbm-compat-dev \
    liblzma-dev \
    libncurses5-dev \
    libreadline6-dev \
    libsqlite3-dev \
    libssl-dev \
    lzma \
    lzma-dev \
    strace \
    tk-dev \
    uuid-dev \
    xvfb \
    zlib1g-dev
  sudo apt-get build-dep -qq python3-defaults
  set -e
}

download_and_verify() {
  wget -nv "https://www.python.org/ftp/python/${pyversion}/${pyarchive}.tgz" \
    -O "${tmp_dir}/${pyarchive}.tgz"
  wget -nv "https://www.python.org/ftp/python/${pyversion}/${pyarchive}.tgz.asc" \
    -O "${tmp_dir}/${pyarchive}.tgz.asc"
  if ! gpg --verify "${tmp_dir}/${pyarchive}.tgz.asc"; then
    err "Signature check of downloaded files failed - make sure the GPG keys are imported!"
    err "--> See https://www.python.org/downloads/metadata/pgp/"
    exit 1
  fi
}

extract() {
  echo "Extracting sources to '${source_dir}'"
  tar -xf "${tmp_dir}/${pyarchive}.tgz" -C "${tmp_dir}"
}

build() {
  cd "${source_dir}"
  echo "Configuring"
  ./configure --enable-optimizations --with-lto=yes
  echo "Running make"
  make -j 4
  echo "Running make altinstall"
  sudo make altinstall
}

clean_up() {
  if [[ -d "${tmp_dir}" ]]; then
    echo "Deleting temporary directory '${tmp_dir}'"
    sudo rm -rf "${tmp_dir:?}"
  fi
}

main() {
  if [[ "$#" -ne 1 ]]; then
    echo "Usage: install_python.sh [PYTHON VERSION]"
    exit 1
  fi
  readonly pyversion="$1"
  readonly pyarchive="Python-${pyversion}"
  readonly tmp_dir=$(mktemp -d -t ${pyarchive}-install.XXXXXXXXXX)
  readonly source_dir="${tmp_dir:?}/${pyarchive}"
  echo "Using temporary directory '${tmp_dir}'"

  set -u

  download_and_verify
  install_dependencies
  extract
  build
  echo "Successfully installed Python ${pyversion}"
}

trap clean_up EXIT
main "$@"
