# mulle-objc-developer

[![Build Status](https://travis-ci.org/mulle-objc/mulle-objc-developer.svg)](https://travis-ci.org/mulle-objc/mulle-objc-developer)
![GitHub tag](https://img.shields.io/github/tag/mulle-objc/mulle-objc-developer.svg)
![GitHub release](https://img.shields.io/github/release/mulle-objc/mulle-objc-developer.svg)


This project packages all items together into a single homebrew formula. This is also the goto project for issues, that don't match any of the other projects or its unclear where they belong.

You install **mulle-objc-developer** with [brew](//brew.sh):

```
brew install mulle-objc/software/mulle-objc-developer
```

This will install the necessary **mulle-objc** packages to write
Objective-C code and the [mulle-clang](//github.com/codeon-gmbh/mulle-clang)
compiler.

> See [mulle-objc Community](//mulle-objc.github.io) for more information.


## Xcode integration

You can get Xcode integration for **mulle-clang**. mulle-clang will appear as
an available compiler in Xcode in the "Build Settings":

![Screeny](pix/xcode-integration.png)


<br>
Run [`mulle-clang-add-to-xcode.sh`](mulle-clang-add-to-xcode.sh) to integrate
the **mulle-clang** compiler into Xcode. This will install a plugin in
`~/Volumes/Users/nat/Library/Application\ Support/Developer/Shared/Xcode/Plug-ins`:

```
mulle-clang-add-to-xcode.sh
```

The `.xcconfig` string for the compiler is:

```
GCC_VERSION = de.codeon.compilers.mulle-clang
```


## Developing mulle-objc itself

If you want to hack on `mulle-objc` it is easiest to use the supplied
script [`mulle-objc-clone.sh`](mulle-objc-clone.sh) to setup things on
your machine.


This needs [mulle-build](//mulle-nat/mulle-build) as a pre-requisite.

```
brew tap mulle-kybernetik/software
brew install mulle-build
brew tap codeon-gmbh/software
brew install mulle-clang
```

```
mulle-objc-clone.sh
```

