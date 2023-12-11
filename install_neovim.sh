#!/bin/bash

MIN_NVIM_VERSION=0.9.0

dpkg -s "neovim" &> /dev/null
is_installed_dpkg=$?

for directory in $(echo $PATH | tr ':' '\n'); do
    find $directory -name "nvim" | grep -q "."
    is_installed_manually=$?
    
    if [ $is_installed_manually -eq 0 ]; then
	echo "Found neovim installation at ${directory}/nvim!"
        break
    fi
done

# utility to compare semver strings, from https://apple.stackexchange.com/a/123408/11374
function version { echo "$@" | awk -F. '{ printf("%d%03d%03d%03d\n", $1,$2,$3,$4); }'; }

if [ $is_installed_dpkg -eq 0 ] || [ $is_installed_manually -eq 0 ]; then
    nvim_version=$(nvim --version | head -1 | grep -o '[0-9]\.[0-9]*.[0-9]*')

    if [ $(version $nvim_version) -ge $(version MIN_NVIM_VERSION) ]; then
	echo "Exiting, since neovim ${nvim_version} is already installed!"
	exit 0
    else
	echo "The installed neovim version ${nvim_version} < ${MIN_NVIM_VERSION}, proceeding with update"
	#TODO: prompt user to remove existing installation
    fi
fi

# Check if user has sudo privilege
if sudo -n false; then
    echo "Exiting, sudo access is required to install the necessary dependencies"
    exit 1
fi

apt-get -y install --no-install-recommends ninja-build gettext cmake unzip curl ca-certificates file

update-ca-certificates

if [ ! -d "neovim" ]; then
    git clone https://github.com/neovim/neovim
fi

cd neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo
git checkout stable

cd build && cpack -G DEB && sudo dpkg -i nvim-linux64.deb
