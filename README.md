# Stuurman

Stuurman is a Ship crewed by AI crew members; you are its Captain. This
repository publishes the `stuurman` command, which installs a Ship on a Mac or
a Linux machine and starts, stops and upgrades it. Docker with Compose is
needed.

Install it with one line:

    curl -fsSL https://install.stuurman.io | bash

or with Homebrew:

    brew tap twimba/stuurman
    brew install stuurman && stuurman install

The first line downloads the command for your machine, checks it against its
SHA-256, installs it and runs `stuurman install`. To read the script before
you run it, open https://install.stuurman.io/install.sh (the address in the
line holds the same script, which a browser shows badly). `stuurman upgrade`
brings a Ship to the latest version (with Homebrew: `brew update && brew upgrade stuurman`, then
`stuurman upgrade`).

To run release candidates before they are released, install
`stuurman-unstable` beside `stuurman`, the same two ways:

    curl -fsSL https://install.stuurman.io/unstable/ | bash

or

    brew install twimba/stuurman/stuurman-unstable && stuurman-unstable install

`stuurman-unstable` is the same command; it follows the newest release
candidate or release, and upgrades only the Ships you move onto release
candidates with it. Such a Ship goes on to newer candidates and releases and
never back to an older release. `stuurman` itself is left as it is.

What is here: the Homebrew formulas (`Formula/stuurman.rb`,
`Formula/stuurman-unstable.rb`), the install scripts and the latest versions
(`docs/`, and `docs/unstable/` for `stuurman-unstable`, served at
https://install.stuurman.io), and, under Releases, the command's builds with
their `checksums.txt`.

Questions: open an issue in this repository.
