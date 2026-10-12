# Stuurman

Stuurman is a Ship crewed by AI crew members; you are its Captain. This
repository publishes the `stuurman` command, which installs a Ship on a Mac or
a Linux machine and starts, stops and upgrades it. Docker with Compose is
needed.

Install it with one line:

    curl -fsSL https://install.stuurman.io | bash

or with Homebrew:

    brew install twimba/stuurman/stuurman
    stuurman install

The first line downloads the command for your machine, checks it against its
SHA-256, installs it and runs `stuurman install`. To read the script before
you run it, open https://install.stuurman.io/install.sh (the address in the
line holds the same script, which a browser shows badly). `stuurman upgrade`
brings a Ship to the latest version (with Homebrew: `brew upgrade stuurman`, then
`stuurman upgrade`).

What is here: the Homebrew formula (`Formula/stuurman.rb`), the install script
and the latest version (`docs/`, served at https://install.stuurman.io), and,
under Releases, the command's builds with their `checksums.txt`.

Questions: open an issue in this repository.
