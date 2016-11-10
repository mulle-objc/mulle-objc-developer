# mulle-objc-developer

![GitHub version](https://badge.fury.io/gh/mulle-nat%2Fmulle-c11.svg) [![Build Status](https://travis-ci.org/mulle-objc/mulle-objc-developer.svg)](https://travis-ci.org/mulle-objc/mulle-objc-developer)

This project packages all items together into a single homebrew formula. If you install this item with [brew](//brew.sh):

```
brew tap mulle-objc/software
brew install mulle-objc-developer
```

you will get all necessary **mulle-objc** packages installed to write Objective-C code.

> See [mulle-objc Community](//mulle-objc.github.io) for moreinformation.


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
> ```

