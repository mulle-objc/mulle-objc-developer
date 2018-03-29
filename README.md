# mulle-objc-developer,  <|PROJECT_DESCRIPTION|>

This is your mulle-sde extension template.

See the [mulle-sde Wiki](https://github.com/mulle-sde/mulle-sde/wiki) for
information about how to develop extensions.


## Test without installation

See if your extension is found by **mulle-sde** by running:

```
MULLE_SDE_EXTENSION_PATH="${PWD}/src:${MULLE_SDE_EXTENSION_PATH}" \
   mulle-sde extension list --all
```

Get detailed information about your extension with *extension usage*:

```
MULLE_SDE_EXTENSION_PATH="${PWD}/src:${MULLE_SDE_EXTENSION_PATH}" \
   mulle-sde extension usage --info --list '*' mulle-objc:mulle-objc-developer
```

## Install

```
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=/usr/local ..
make install
```
