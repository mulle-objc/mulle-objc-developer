# mulle-objc-developer

![GitHub version](https://badge.fury.io/gh/mulle-nat%2Fmulle-c11.svg) [![Build Status](https://travis-ci.org/mulle-objc/mulle-objc-developer.svg)](https://travis-ci.org/mulle-objc/mulle-objc-developer)

This project packages all items together into a single homebrew formula.

> This is also the goto project for issues, that don't match any of the other projects or its unclear where they belong.

If you install this item with [brew](//brew.sh):

```
brew tap mulle-objc/software
brew tap codeon-gmbh/software
brew install mulle-objc-developer
```

you will get all necessary **mulle-objc** packages installed to write
Objective-C code and the [mulle-clang](//github.com/codeon-gmbh/mulle-clang)
compiler.

> See [mulle-objc Community](//mulle-objc.github.io) for more information.


## Developing mulle-objc itself

If you want to hack on `mulle-objc` it is easiest to use the supplied
script  [`mulle-objc-clone.sh`](mulle-objc-clone.sh) to setup things on
your machine.

```
./bin/mulle-objc-clone.sh
```

>This needs [mulle-build](//mulle-nat/mulle-build) as a pre-requisite.
>
> ```
> brew tap mulle-kybernetik/software
> brew install mulle-build
> brew tap codeon-gmbh/software
> brew install mulle-clang
> ```

