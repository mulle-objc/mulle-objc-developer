##  Xcode 7

You can get compiler integration for **mulle-clang** into *Xcode 7* ot earlier. 
**mulle-clang** will appear as an available compiler in Xcode in the "Build Settings":

![Screeny](https://github.com/mulle-objc/mulle-objc-developer/blob/master/pix/xcode-integration.png)


<br>
Run [mulle-clang-add-to-xcode](mulle-clang-add-to-xcode) to integrate
the **mulle-clang** compiler into Xcode. This will install a plugin in
`~/Volumes/Users/nat/Library/Application\ Support/Developer/Shared/Xcode/Plug-ins`:

```
mulle-clang-add-to-xcode
```

The `.xcconfig` string for the compiler is:

```
GCC_VERSION = de.codeon.compilers.mulle-clang
```
