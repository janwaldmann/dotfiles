#!/bin/bash
#
# Download, build and install a given Python version on Ubuntu.
# Usage: install_python.sh [PYTHON VERSION]
#
# make altinstall is used for installation, which means the binary has a
# version suffix.
# 

err() {
  echo "ERROR: $*" >&2
}

warn() {
  echo "WARNING: $*" >&1
}

install_deps() {
  echo "Installing dependencies"
  sudo apt update -q
  sudo apt install -q --assume-yes wget tar build-essential gdb lcov pkg-config \
    libbz2-dev libffi-dev libgdbm-dev libgdbm-compat-dev liblzma-dev \
    libncurses5-dev libreadline6-dev libsqlite3-dev libssl-dev \
    lzma lzma-dev tk-dev uuid-dev zlib1g-dev libdb5.3-dev
}

download() {
  wget "https://www.python.org/ftp/python/${pyversion}/${pyarchive}.tgz" \
    -O "${tmp_dir}/${pyarchive}.tgz" || exit 1
  wget "https://www.python.org/ftp/python/${pyversion}/${pyarchive}.tgz.asc" \
    -O "${tmp_dir}/${pyarchive}.tgz.asc" 
  if ! gpg --verify "${tmp_dir}/${pyarchive}.tgz.asc"; then
    err "Signature check of downloaded files failed - make sure the GPG keys are imported"
    rm "${tmp_dir:?}/${pyarchive:?}.tgz" && rm "${tmp_dir:?}/${pyarchive:?}.tgz.asc"
    exit 1
  fi
}

extract() {
  if [[ -d "${source_dir}" ]]; then
    warn "Source directory '${source_dir}' already exists; contents will be replaced"
    sudo rm -rf "${source_dir:?}"
  fi
  echo "Extracting sources to '${source_dir}'"
  tar -xf "${tmp_dir}/${pyarchive}.tgz" -C "${tmp_dir}"
  rm "${tmp_dir:?}/${pyarchive:?}.tgz" && rm "${tmp_dir:?}/${pyarchive:?}.tgz.asc"
}

build() {
  cd "${source_dir}" || exit 1
  echo "Configuring"
  ./configure --enable-optimizations
  echo "Running make"
  make -j 4
  echo "Running make altinstall"
  sudo make altinstall
}

clean_up() {
  echo "Removing source directory '${source_dir}'"
  sudo rm -rf "${source_dir:?}"
}

main() {
  if [[ "$#" -ne 1 ]]; then
    echo "Usage: install_python.sh [PYTHON VERSION]"
    exit 1
  fi
  readonly pyversion="$1"
  if [[ -z "${TMPDIR}" ]]; then
    readonly tmp_dir="/tmp"
  else 
    readonly tmp_dir="${TMPDIR}"
  fi
  echo "Using '${tmp_dir}' for temporary files"
  if [[ ! -d "${tmp_dir}" ]]; then
    err "Temporary directory '${tmp_dir}' does not exist"
    exit 1
  fi
  readonly pyarchive="Python-${pyversion}"
  readonly source_dir="${tmp_dir}/${pyarchive}"

  install_deps
  download
  extract
  build
  clean_up
  echo "Done"
}

main "$@"
