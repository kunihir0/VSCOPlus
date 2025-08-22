
# VscoPlus

Minimal tweak for VSCO app. Adds a floating button for quick access to features.


## Requirements
- Jailbroken IOS Device(15.4+)
- [libFLEX](https://github.com/Flipboard/FLEX)
- [FLEXing](https://github.com/alias20/FLEXing)

^ Above libs can be found on the [alias20](https://alias20.gitlab.io/apt/) repo

- Tested on VSCO(v434.0.5)


## Features
- Save images directly to Photos
- Toggle FLEX debugging tool
- Block ads and ad views

## Building from source
```Bash
export THEOS_DEVICE_IP=youriosdeviceiphere
export ARCHS=arm64 #change this depending on your ios device
make clean
make package
make install
```

## Installing from package
Check the GitHub Releases page for the latest `.deb` packages to install manually with you're respective package manager.
