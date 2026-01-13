## 0.28.0

Various small improvements


### 0.27.2

Various small improvements

### 0.27.1

* fix wrong include in demo library

## 0.27.0

feat: improve build system and environment handling

* Enhance CMake configuration and build
  - Add `OBJC_TAO_DEBUG_ENABLED` option for debug builds
  - Update library linking with `WHOLE_ARCHIVE` support
  - Fix paths to use `CMAKE_CURRENT_SOURCE_DIR` consistently
  - Add config template for package installation

* Update VSCode integration
  - Use environment variables for include paths
  - Update debug configuration paths
  - Improve IntelliSense settings

* Environment and workflow improvements
  - Update GitHub Actions to use checkout@v4
  - Add `workflow_dispatch` support
  - Fix environment plugin handling
  - Update environment version to 5.3.0

* Other improvements
  - Enable include.h and include-private.h conditionals
  - Update trace environment variable name
  - Fix project version handling
  - Add mulle-clang-project dependency


### 0.26.1

* Various small improvements

## 0.26.0

* update version numbers to use unsigned long
* .inc files are no long considered for public headers, but are not project header by default
* project headers is now a thing...
* fix import.h accidentally including include-private.h


## 0.25.0

* remove package.json as it conflicts with clib.json
* changes to objc-loader and linking


## 0.24.0

* Various small improvements


## 0.23.0

* changes for Windows
* improved Library identifier code


## 0.22.0

* improved compiler flags generation


## 0.21.0

* split file.m into file.m and class.m
* added loader.m
* remove **travis**

## 0.20.0

* updated Dockerfile

## 0.19.0

* added protocol template (use mulle-sde add -t protocol FooProtocol.m to use)
* github actions extension
* improved file.m/h template can now set superclass if desired


## 0.18.0

* use newer style extension files from mulle-sde 0.42


## 0.17.0

* templates for protocolclasses


## 0.16.0

* 0.16 release


### 0.15.2

* fix missing header files for sure now

### 0.15.1

* fix missing header files

## 0.15.0

* Various small improvements


### 0.14.8

* fix travis

### 0.14.7

* restructured for mulle-sde-developer changes

### 0.14.6

* renamed dependency to dependencies for newest mulle-sde

### 0.14.5

* remove old .mulle-make folders

### 0.14.4

* modernized mulle-sde with .mulle folder

### 0.14.3

* Various small improvements

### 0.14.2

* fix travis

### 0.14.1

* remove duplicate startup cmake code from mulle-objc

## 0.14.0

* renamed vs-code to vs-code-clang
* removed cmake startup logic


### 0.13.1

* fix for mingw, fix Startup

## 0.14.0

* adapt to use of delete instead of clobber


### 0.13.2

* fix startup patternfile

### 0.13.1

* fix private patternfile, move files from cmake to objc where they belong

## 0.13.0

* Various small improvements
