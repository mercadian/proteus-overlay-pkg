# proteus-overlay-pkg
This repo contains the source to build the Proteus device tree overlay for the front panel and its associated config files that update the bootloader configuration after installing a kernel update.

It also contains the source for building the Debian package that installs those files.


## Prerequisites

To run this, you will need the following packages:

```bash
sudo apt install device-tree-compiler devscripts
```


## Building

Simply run `build.sh` to build the files.

The Device Tree Overlay itself will be in `out/sta-led-overlay.dtbo`.

The Debian package will be in `out/proteus-overlay-<version>.deb`.