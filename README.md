# mulle-objc-developer

[![Build Status](https://travis-ci.org/mulle-nat/mulle-objc-developer.svg)](https://travis-ci.org/mulle-objc/mulle-objc-developer)
![GitHub tag](https://img.shields.io/github/tag/mulle-nat/mulle-objc-developer.svg)
![GitHub release](https://img.shields.io/github/release/mulle-nat/mulle-objc-developer.svg)


This project installs the minimally required items for developing
**mulle-objc** on your system.

It will install the compiler **mulle-clang** and a
script **mulle-objc-init**, with that you can start developing.


## Installation

### Install on OS X

You install **mulle-objc-developer** with [brew](//brew.sh):

```
brew install mulle-kybernetik/software/mulle-objc-developer
```


### Install on Unbuntu Linux and WSL/bash

This methods works for **trusty**, **xenial** and **zesty**:

```
curl -L -O 'https://raw.githubusercontent.com/mulle-nat/mulle-objc-developer/release/install-ubuntu.sh'
chmod 755 install-ubuntu.sh
./install-ubuntu.sh
```

## Create a mulle-objc project

### mulle-objc-init

Use `mulle-objc-init` to create a hello world project. This will download and
compile quite a few dependencies.


```
mulle-objc-init --cache -d /tmp/demo executable
cd /tmp/demo
mulle-build --bootstrap
```

Now run your Objective-C executable:

```
./build/demo
```

Your code and your project is automatically portable across all supported platforms!



### mulle-objc-init usage

```
usage:
   mulle-objc-init [options] [command]

   Options:
      -d <dir>   : use "dir" instead of working directory
      --dev      : add conventional configurations for MulleObjC developers
      -f         : overwrite existing files
      -n         : don't actually do anything

   Command:
      check      : check current project
      executable : create a mulle-objc executable project
      library    : create a mulle-objc library project
      version    : print mulle-objc-developer version
```

### Using Xcode

If you want to use Xcode to edit your files, you can use **cmake** to generate
an Xcode project for your project.

```bash
mkdir build-xcode.d ; cd build-xcode.d ; cmake -G "Xcode" .. ; open *.xcodeproj
```

## Developing mulle-objc itself

If you want to hack on **mulle-objc** it is easiest to use the supplied
script [`mulle-objc-clone`](mulle-objc-clone) to setup things on
your machine.

Run `mulle-objc-clone` in a directory, where you want the repositories
to reside in. Then you can just compile and test any project conveniently
with **mulle-build**:

```
mkdir rootdir
cd rootdir
mulle-objc-clone
#
cd MulleObjC
mulle-build -y --bootstrap
mulle-test
```

## Links

Visit the [mulle-objc community](https://mulle-objc.github.io) for more information.
