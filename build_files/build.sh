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

sed -i 's/^enabled=0/enabled=1/' /etc/yum.repos.d/terra.repo /etc/yum.repos.d/terra-extras.repo

dnf5 -y install \
  hyprland \
  udiskie \
  dms \
  grim slurp \
  ghostty \
  eza fd-find ripgrep starship \
  neovim

for repo in "${repos[@]}"; do
  dnf5 -y copr disable "$repo"
done

sed -i 's/^enabled=1/enabled=0/' /etc/yum.repos.d/terra.repo /etc/yum.repos.d/terra-extras.repo
