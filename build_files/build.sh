#!/bin/bash

set -ouex pipefail

# Copy the contents of system_files/ of the git repo to /
cp -avf "/ctx/system_files"/. /

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/43/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos

repos=(
  "lionheartp/Hyprland"
  "duxlabs/dms-git"
)

for repo in "${repos[@]}"; do
  dnf5 -y copr enable "$repo"
done

dnf5 -y install --enablerepo=terra --allowerasing \
  hyprland hyprland-guiutils xdg-desktop-portal-hyprland \
  udiskie \
  stow \
  git \
  dms \
  grim slurp \
  ghostty kitty \
  eza fd-find ripgrep starship \
  neovim

for repo in "${repos[@]}"; do
  dnf5 -y copr disable "$repo"
done
