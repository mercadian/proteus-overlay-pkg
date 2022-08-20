# proteus-overlay-pkg
This repo contains the source to build the Proteus device tree overlay for the front panel and its associated config files that update the bootloader configuration after installing a kernel update.

It also contains the source for building the Debian package that installs those files.


## Prerequisites

To run this, you will need the following packages:

```bash
sudo apt install device-tree-compiler devscripts lintian
```


## Building

To build the package, run:

```
debuild -b -us -uc -aarm64
```

The output will be in the parent directory of this folder because of the way the Debian builder works.
