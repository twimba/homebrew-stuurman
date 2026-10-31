#!/bin/sh
# The install script of Stuurman, a Ship crewed by AI crew members. Run it with
#
#   curl -fsSL https://install.stuurman.io | bash
#
# It downloads the stuurman command for this machine (a Mac with Apple silicon,
# or Linux on arm64), checks it against its SHA-256, puts it in /usr/local/bin (or in
# ~/.local/bin when that folder cannot be written; it never runs sudo) and
# runs `stuurman install`, which starts a Ship. Docker with Compose is needed;
# `stuurman install` checks it. Arguments go on to `stuurman install`:
#
#   curl -fsSL https://install.stuurman.io | bash -s -- --dir ~/ship --port 9000
#
# With restore as the first argument it runs `stuurman restore` with the rest
# instead, which restores a Ship from a backup rather than starting a new one:
#
#   curl -fsSL https://install.stuurman.io | bash -s -- restore <backup file>
#
# STUURMAN_VERSION=v1.2.3 installs that version instead of the latest one.
#
# The copy at https://install.stuurman.io/unstable/ installs stuurman-unstable,
# the same command that also follows release candidates: it is this script
# with the two lines below rewritten by scripts/render-tap.sh --unstable, so it
# reads unstable/latest (a release candidate or a release), installs the
# command as stuurman-unstable beside any stuurman and runs
# `stuurman-unstable install`.
#
# Everything below is a function; the last line runs it, in braces. A download
# that was cut off anywhere, inside the last line too, therefore runs nothing.
set -eu
command_name=stuurman-unstable
latest_path=unstable/latest

refuse() {
  printf '%s: %s\n' "$command_name" "$*" >&2
  exit 1
}

# cleanup removes what a run leaves behind: the folder of the downloads and a
# file that was copied into the install folder but not yet renamed.
cleanup() {
  if [ -n "${STAGED:-}" ]; then rm -f -- "$STAGED"; fi
  if [ -n "${WORK:-}" ]; then rm -rf -- "$WORK"; fi
}

# is_version <value> <stable|any>: whether the value is a version (v1.2.3;
# with "any" also v1.2.3-rc.1). The first check leaves no character, and so no
# line break, that the second (which reads lines) could be fooled by. It runs
# in a shell of its own with LC_ALL=C, so that a-z means the same letters
# under every shell and language.
is_version() (
  LC_ALL=C
  export LC_ALL
  case "$1" in
    '' | *[!0-9A-Za-z.-]*) return 1 ;;
  esac
  [ "${#1}" -le 64 ] || return 1
  if [ "$2" = stable ]; then
    printf '%s\n' "$1" | grep -Eq '^v[0-9]+\.[0-9]+\.[0-9]+$'
  else
    printf '%s\n' "$1" | grep -Eq '^v[0-9]+\.[0-9]+\.[0-9]+(-[0-9A-Za-z.-]+)?$'
  fi
)

# base <variable name> <its value> <default>: prints the address to read
# from, without a slash at its end. A value from the shell (the tests set
# one, and so can a person who keeps a copy of the releases) must be
# https://<host>, or http:// on this host alone; a port is digits. It
# runs in a shell of its own with LC_ALL=C, like is_version.
base() (
  LC_ALL=C
  export LC_ALL
  if [ -z "$2" ]; then
    printf '%s\n' "$3"
    return 0
  fi
  no="$1 must be an https:// address."
  case "$2" in
    *[!][A-Za-z0-9._~:/%-]*) refuse "$no" ;;
  esac
  case "$2" in
    https://*) scheme=https; rest="${2#https://}" ;;
    http://*) scheme=http; rest="${2#http://}" ;;
    *) refuse "$no" ;;
  esac
  hostport="${rest%%/*}"
  port=0
  case "$hostport" in
    '['*']') host="$hostport" ;;
    '['*']':*) host="${hostport%:*}"; port="${hostport##*:}" ;;
    *:*) host="${hostport%%:*}"; port="${hostport#*:}" ;;
    *) host="$hostport" ;;
  esac
  case "$port" in
    '' | *[!0-9]*) refuse "$no" ;;
  esac
  case "$host" in
    '' | '[]' | '['*[!0-9A-Fa-f:.]*']') refuse "$no" ;;
    '['*']') ;;
    *[!A-Za-z0-9.-]*) refuse "$no" ;;
  esac
  if [ "$scheme" = http ]; then
    case "$host" in
      127.0.0.1 | localhost | '[::1]') ;;
      *) refuse "$no" ;;
    esac
  fi
  b="$2"
  while [ "${b%/}" != "$b" ]; do b="${b%/}"; done
  printf '%s\n' "$b"
)

# fetch <address> <file>: downloads the address into the file, in five minutes
# at most. With curl an https address is never left for another protocol,
# redirects included (wget has no way to say that).
fetch() {
  if [ "$DOWNLOADER" = curl ]; then
    case "$1" in
      https://*) curl --proto '=https' --proto-redir '=https' --tlsv1.2 --connect-timeout 15 --max-time 300 -fsSL -o "$2" -- "$1" ;;
      *) curl --connect-timeout 15 --max-time 300 -fsSL -o "$2" -- "$1" ;;
    esac
  else
    wget -T 300 -qO- -- "$1" > "$2"
  fi
}

# sha256 <file>: prints the file's SHA-256 in hexadecimal.
sha256() {
  if [ "$SUMMER" = shasum ]; then
    sum="$(shasum -a 256 "$1")" || return 1
  else
    sum="$(sha256sum "$1")" || return 1
  fi
  printf '%s\n' "${sum%% *}"
}

main() {
  WORK=""
  STAGED=""

  case "$(uname -s)" in
    Darwin) os=darwin ;;
    Linux) os=linux ;;
    *) refuse "Stuurman runs on macOS and Linux, not on $(uname -s)." ;;
  esac
  case "$(uname -m)" in
    arm64 | aarch64) arch=arm64 ;;
    *) refuse "Stuurman runs on arm64 machines only (a Mac with Apple silicon, or Linux on arm64), and this one is $(uname -m). On a Mac with Apple silicon, run it in a terminal that does not use Rosetta." ;;
  esac

  if command -v curl >/dev/null 2>&1; then
    DOWNLOADER=curl
  elif command -v wget >/dev/null 2>&1; then
    DOWNLOADER=wget
  else
    refuse "Neither curl nor wget is installed; install one and run the install line again."
  fi
  if command -v shasum >/dev/null 2>&1; then
    SUMMER=shasum
  elif command -v sha256sum >/dev/null 2>&1; then
    SUMMER=sha256sum
  else
    refuse "Neither shasum nor sha256sum is installed, so the download cannot be checked; install one and run the install line again."
  fi
  for tool in tar awk grep mktemp; do
    command -v "$tool" >/dev/null 2>&1 || refuse "$tool is not installed; install it and run the install line again."
  done

  pages="$(base STUURMAN_INSTALL_BASE "${STUURMAN_INSTALL_BASE:-}" https://install.stuurman.io)" || exit 1
  downloads="$(base STUURMAN_DOWNLOAD_BASE "${STUURMAN_DOWNLOAD_BASE:-}" https://github.com/twimba/homebrew-stuurman/releases/download)" || exit 1

  # Where the command goes: decided, and looked at, before anything is
  # downloaded. A link there is not replaced: it is Homebrew's when the
  # command was installed with brew, and brew would no longer know its own
  # install.
  if [ -d /usr/local/bin ] && [ -w /usr/local/bin ]; then
    bindir=/usr/local/bin
  else
    [ -n "${HOME:-}" ] || refuse "/usr/local/bin cannot be written and HOME is not set; set HOME and run the install line again."
    bindir="$HOME/.local/bin"
  fi
  if [ -L "$bindir/$command_name" ]; then
    refuse "$bindir/$command_name is a link, not a file (Homebrew's, if $command_name was installed with brew: run brew update && brew upgrade $command_name instead). Remove the link to install here, then run the install line again."
  fi
  [ ! -d "$bindir/$command_name" ] || refuse "$bindir/$command_name is a folder; remove it and run the install line again."

  WORK="$(mktemp -d "${TMPDIR:-/tmp}/stuurman-install.XXXXXXXX")" || refuse "A temporary folder could not be made in ${TMPDIR:-/tmp}; set TMPDIR to a folder that can be written and run the install line again."
  trap cleanup EXIT
  trap 'exit 129' HUP
  trap 'exit 130' INT
  trap 'exit 143' TERM

  version="${STUURMAN_VERSION:-}"
  if [ -n "$version" ]; then
    is_version "$version" any || refuse "STUURMAN_VERSION must be a version like v1.2.3."
  else
    # stuurman takes only a release from latest; stuurman-unstable takes a
    # release candidate from unstable/latest too.
    kind=stable
    [ "$latest_path" = latest ] || kind=any
    fetch "$pages/$latest_path" "$WORK/latest" || refuse "The latest version could not be read from $pages/$latest_path; check the connection and run the install line again."
    version="$(cat "$WORK/latest")" || refuse "The latest version could not be read from $pages/$latest_path; run the install line again."
    is_version "$version" "$kind" || refuse "$pages/$latest_path does not hold a version; run the install line again later."
  fi

  name="stuurman_${version}_${os}_${arch}.tar.gz"
  printf 'Downloading %s %s for %s on %s.\n' "$command_name" "$version" "$os" "$arch"
  fetch "$downloads/$version/checksums.txt" "$WORK/checksums.txt" || refuse "$downloads/$version/checksums.txt could not be downloaded; check the connection and run the install line again."
  fetch "$downloads/$version/$name" "$WORK/$name" || refuse "$downloads/$version/$name could not be downloaded; check the connection and run the install line again."

  got="$(sha256 "$WORK/$name")" || refuse "The SHA-256 of $name could not be computed; run the install line again."
  case "$got" in
    *[!0-9a-f]*) refuse "The SHA-256 of $name could not be computed; run the install line again." ;;
  esac
  [ "${#got}" -eq 64 ] || refuse "The SHA-256 of $name could not be computed; run the install line again."
  # Every line of checksums.txt for this file must give the same sum, and
  # there must be one. (shasum's lines: the sum, then the name, which a "*"
  # may precede.)
  rc=0
  awk -v name="$name" -v got="$got" '
    NF == 2 { f = $2; sub(/^\*/, "", f); if (f == name) { found = 1; if (tolower($1) != got) bad = 1 } }
    END { if (!found) exit 4; if (bad) exit 3 }
  ' "$WORK/checksums.txt" || rc=$?
  case "$rc" in
    0) ;;
    4) refuse "checksums.txt has no line for $name; nothing was installed." ;;
    3) refuse "$name does not match its SHA-256 in checksums.txt; nothing was installed. Run the install line again." ;;
    *) refuse "checksums.txt could not be read (awk ended with status $rc); nothing was installed." ;;
  esac

  # Only the entry named stuurman is taken out, and only a plain file is installed.
  mkdir -- "$WORK/build" || refuse "A temporary folder could not be made; run the install line again."
  tar -xzf "$WORK/$name" -C "$WORK/build" stuurman 2>/dev/null || refuse "$name could not be unpacked or holds no file named stuurman; nothing was installed."
  if [ -L "$WORK/build/stuurman" ] || [ ! -f "$WORK/build/stuurman" ] || [ ! -s "$WORK/build/stuurman" ]; then
    refuse "$name could not be unpacked or holds no file named stuurman; nothing was installed."
  fi

  # Copied beside its place and renamed, so the place never holds half a
  # file. The tarball's stuurman is installed under the command's own name:
  # stuurman-unstable knows itself by it.
  mkdir -p -- "$bindir" || refuse "The folder $bindir could not be made; make it and run the install line again."
  STAGED="$bindir/.$command_name.new.$$"
  if command -v install >/dev/null 2>&1; then
    install -m 0755 -- "$WORK/build/stuurman" "$STAGED" || refuse "$command_name could not be written into $bindir; make the folder writable and run the install line again."
  else
    { cp -- "$WORK/build/stuurman" "$STAGED" && chmod 0755 -- "$STAGED"; } || refuse "$command_name could not be written into $bindir; make the folder writable and run the install line again."
  fi
  mv -f -- "$STAGED" "$bindir/$command_name" || refuse "$command_name could not be written into $bindir; make the folder writable and run the install line again."
  STAGED=""
  printf 'Installed %s.\n' "$bindir/$command_name"
  # shellcheck disable=SC2016 # $PATH is printed as it is typed
  case ":${PATH:-}:" in
    *":$bindir:"*) ;;
    *) printf '%s is not on your PATH. Add it (the line export PATH="%s:$PATH" in the start file of your shell does that), or run %s by its full path.\n' "$bindir" "$bindir" "$bindir/$command_name" ;;
  esac
  other="$(command -v "$command_name" 2>/dev/null || true)"
  if [ -n "$other" ] && [ "$other" != "$bindir/$command_name" ]; then
    printf 'Another %s, %s, comes first on your PATH.\n' "$command_name" "$other"
  fi

  # exec leaves no shell behind to run the EXIT trap: clean up first.
  cleanup
  WORK=""
  trap - EXIT
  if [ "${1:-}" = restore ]; then
    shift
    exec "$bindir/$command_name" restore "$@"
  fi
  exec "$bindir/$command_name" install "$@"
}

{ main "$@"; }
