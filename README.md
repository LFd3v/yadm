# yadm - Yet Another Dotfiles Manager

[![Latest Version][releases-badge]][releases-link]
[![Homebrew Version][homebrew-badge]][homebrew-link]
[![OBS Version][obs-badge]][obs-link]
[![Arch Version][arch-badge]][arch-link]
[![License][license-badge]][license-link]<br />
[![Master Update][master-date]][master-commits]
[![Develop Update][develop-date]][develop-commits]
[![Website Update][website-date]][website-commits]<br />
[![Master Status][master-badge]][workflow-master]
[![Develop Status][develop-badge]][workflow-develop]
[![GH Pages Status][gh-pages-badge]][workflow-gh-pages]
[![Dev Pages Status][dev-pages-badge]][workflow-dev-pages]

[https://yadm.io/][website-link]

**yadm** is a tool for managing [dotfiles][].

* Based on [Git][], with full range of Git's features
* Supports system-specific alternative files or templated files
* Encryption of private data using [GnuPG][], [OpenSSL][], [transcrypt][], or
  [git-crypt][]
* Customizable initialization (bootstrapping)
* Customizable hooks for before and after any operation

Complete features, usage, examples and installation instructions can be found on
the [yadm.io][website-link] website.

## Install script

`yadm` is great, it works very well to manage dotfiles, but the initial setup on a new machine is somewhat cumbersome.

This fork adds a install script that can be used to install `yadm` and then clone your dotfiles from a remote repo. No `root` needed, the install script should be easy to verify as safe, and there is a confirmation prompt before anything that could cause problems. The only requirements are `bash`, `git` and `curl` or `wget`.

A symbolic link to [`yadm`](yadm) will be created in `~/bin` if it exists, or in `~/.local/bin` otherwise, as well as a symbolic link to [`yadm.1`](yadm.md) file will be created in `~/.local/share/man/man1` in order to be able to access the `man` page after the installation.

    # Default installation using curl creates a yadm directory in the current path
    bash <(curl -fsSL https://git.envs.net/lfdev/yadm-install/raw/branch/master/install.sh)
    # or using wget
    bash <(wget -qO- https://git.envs.net/lfdev/yadm-install/raw/branch/master/install.sh)

    # Default installation using the shortened URL
    # (if in doubt, verify the URL contents first using curl/wget or a browser)
    bash <(curl -fsSL https://envs.sh/Q_C)
    # or
    bash <(wget -qO- https://envs.sh/Q_C)

    # Installation using the shortened URL and a custom path (full URL also supports a custom path)
    bash <(curl -fsSL https://envs.sh/Q_C) /path/to/install  # installs to /path/to/install/yadm
    bash <(curl -fsSL https://envs.sh/Q_C) relative/path     # installs to $PWD/relative/path/yadm
    # or
    bash <(wget -qO- https://envs.sh/Q_C) /path/to/install
    bash <(wget -qO- https://envs.sh/Q_C) relative/path

Of course, it is possible to download [`install.sh`](install.sh) or the source code, and then run the script locally. In this case, one may also change `CLONE_URL` inside the script to point to the [upstream repo][] if desired. It is also possible to change the repo origin to upstream after the installation and pull future updates from it instead (it will detele the installation script tho):

    cd /path/to/yadm                                        # enter repo directory
    git remote set-url origin https://github.com/TheLocehiliosan/yadm.git
    git pull origin master --rebase
    git pull origin master                                  # or simply git pull for future updates

It is planned to update this miror whenever there is a new `yadm` version. Current and older versions can be found in the [Releases][] page, but the installation script will always install the current repo version.

## A very quick tour

    # Initialize a new repository
    yadm init

    # Clone an existing repository
    yadm clone <url>

    # Add files/changes
    yadm add <important file>
    yadm commit

    # Encrypt your ssh key
    echo '.ssh/id_rsa' > ~/.config/yadm/encrypt
    yadm encrypt

    # Later, decrypt your ssh key
    yadm decrypt

    # Create different files for Linux vs MacOS
    yadm add path/file.cfg##os.Linux
    yadm add path/file.cfg##os.Darwin

If you enjoy using yadm, consider adding a star to the repository on GitHub.
The star count helps others discover yadm.

[Git]: https://git-scm.com/
[GnuPG]: https://gnupg.org/
[OpenSSL]: https://www.openssl.org/
[arch-badge]: https://img.shields.io/archlinux/v/extra/any/yadm
[arch-link]: https://archlinux.org/packages/extra/any/yadm/
[dev-pages-badge]: https://img.shields.io/github/actions/workflow/status/TheLocehiliosan/yadm/test.yml?branch=dev-pages
[develop-badge]: https://img.shields.io/github/actions/workflow/status/TheLocehiliosan/yadm/test.yml?branch=develop
[develop-commits]: https://github.com/TheLocehiliosan/yadm/commits/develop
[develop-date]: https://img.shields.io/github/last-commit/TheLocehiliosan/yadm/develop.svg?label=develop
[dotfiles]: https://en.wikipedia.org/wiki/Hidden_file_and_hidden_directory
[gh-pages-badge]: https://img.shields.io/github/actions/workflow/status/TheLocehiliosan/yadm/test.yml?branch=gh-pages
[git-crypt]: https://github.com/AGWA/git-crypt
[homebrew-badge]: https://img.shields.io/homebrew/v/yadm.svg
[homebrew-link]: https://formulae.brew.sh/formula/yadm
[license-badge]: https://img.shields.io/github/license/TheLocehiliosan/yadm.svg
[license-link]: https://github.com/TheLocehiliosan/yadm/blob/master/LICENSE
[master-badge]: https://img.shields.io/github/actions/workflow/status/TheLocehiliosan/yadm/test.yml?branch=master
[master-commits]: https://github.com/TheLocehiliosan/yadm/commits/master
[master-date]: https://img.shields.io/github/last-commit/TheLocehiliosan/yadm/master.svg?label=master
[obs-badge]: https://img.shields.io/badge/OBS-v3.2.2-blue
[obs-link]: https://software.opensuse.org//download.html?project=home%3ATheLocehiliosan%3Ayadm&package=yadm
[releases-badge]: https://img.shields.io/github/tag/TheLocehiliosan/yadm.svg?label=latest+release
[releases-link]: https://github.com/TheLocehiliosan/yadm/releases
[upstream repo]: https://github.com/TheLocehiliosan/yadm.git
[transcrypt]: https://github.com/elasticdog/transcrypt
[travis-ci]: https://travis-ci.com/TheLocehiliosan/yadm/branches
[website-commits]: https://github.com/TheLocehiliosan/yadm/commits/gh-pages
[website-date]: https://img.shields.io/github/last-commit/TheLocehiliosan/yadm/gh-pages.svg?label=website
[website-link]: https://yadm.io/
[workflow-dev-pages]: https://github.com/thelocehiliosan/yadm/actions?query=workflow%3a%22test+site%22+branch%3adev-pages
[workflow-develop]: https://github.com/TheLocehiliosan/yadm/actions?query=workflow%3ATests+branch%3Adevelop
[workflow-gh-pages]: https://github.com/thelocehiliosan/yadm/actions?query=workflow%3a%22test+site%22+branch%3agh-pages
[workflow-master]: https://github.com/TheLocehiliosan/yadm/actions?query=workflow%3ATests+branch%3Amaster
[Releases]: https://git.envs.net/lfdev/yadm-install/releases