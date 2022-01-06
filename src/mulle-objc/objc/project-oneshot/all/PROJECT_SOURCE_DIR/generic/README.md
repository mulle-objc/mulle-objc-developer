# generic

The contents of this folder are editable.

## Raison d'^etre

To improve the motility of sources and headers, the "generic" `#include.h`
files (and friends) are kept in this separate folder.

When a file from this project is used via a symlink in another project for
some quick test, the other project generic headers will be picked up and not
the generic headers here.

Keep this folder free of non-generic headers. It's not called **header** or
**include** for a reason.


## Header files in `reflect`


### `import.h`

This is what your Objective-C headers should import and only import. The only
exceptions are headers in this project, which can't appear in `import.h`.

Manage system headers with `mulle-sde library`.
Manage dependency headers with `mulle-sde dependency`.

### `import-private.h`

This is what your C sources should include. Your C source should also import
it's a header, if applicable and the needed headers that are in this
project.

Manage system headers with `mulle-sde library` and mark them `no-public`.
Manage dependency headers with `mulle-sde dependency` and mark them `no-public`.


## Other header files in `reflect`

In mixed libraries, where you want to expose also functionality to C only
customers, you need these two files.

### `include.h`

This is what your C headers should include and only include. The only
exceptions are headers in this project, which can't appear in `include.h`.

Manage system headers with `mulle-sde library`.
Manage dependency headers with `mulle-sde dependency`.

### `include-private.h`

This is what your C sources should include. Your C source should also include
it's a header, if applicable and the needed headers that are in this
project.

Manage system headers with `mulle-sde library` and mark them `no-public`.
Manage dependency headers with `mulle-sde dependency` and mark them `no-public`.

