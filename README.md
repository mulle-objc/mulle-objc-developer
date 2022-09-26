# mulle-objc

#### 🎩 mulle-objc developer kit for mulle-sde

This is a collection of [mulle-sde](//github.com/mulle-sde/mulle-sde)
*extensions* to support development of [MulleObjC](//github.com/mulle-objc)
code. As a package **mulle-objc-developer** is also a convenient way to
install mulle-sde and [mulle-clang](//github.com/Codeon-GmbH/mulle-clang).

> See the [mulle-sde Wiki](//github.com/mulle-sde/mulle-sde/wiki) for
> an introduction on **mulle-sde**.


Extension                      | Type      | Description
-------------------------------|-----------|-----------------------------------
mulle-objc/objc-developer      | meta      | Create Objective-C projects


## Install

### Packages

OS      | Command
--------|------------------------------------
macos   | `brew install mulle-kybernetik/software/mulle-objc-developer`
debian  | `sudo apt-get -y install mulle-objc-developer` (but see below)
ubuntu  | same as debian


#### Debian Mulle kybernetiK repositories

For apt installation you need to add the Mulle kybernetiK debian
repository first:

``` sh
get -O - "//www.mulle-kybernetik.com/dists/debian-admin-pub.asc" | sudo apt-key add -
echo "deb [arch=all] http://www.mulle-kybernetik.com `lsb_release -c -s` main" | sudo tee "/etc/apt/sources.list.d/mulle-kybernetik.com-main.list" > /dev/null
sudo apt-get update
```


### Script

mulle-sde provides an [installer-all](//raw.githubusercontent.com/mulle-sde/mulle-sde/release/bin/installer-all) script to install the required commands and mulle-sde-developer itself into `/usr` or some other place.

You need to install [mulle-clang](//github.com/Codeon-GmbH/mulle-clang) yourself.

This is suitable for environments without supported package managers:

#### Install into /usr with sudo

``` sh
curl -L -O '//raw.githubusercontent.com/mulle-sde/mulle-sde/release/bin/installer-all' && \
chmod 755 installer-all && \
sudo OTHER_PROJECTS="mulle-objc/mulle-objc-developer;latest \
mulle-c/mulle-c-developer;latest" \
SDE_PROJECTS="mulle-sde-developer;latest" ./installer-all /usr
```

#### Install into ${HOME} (without sudo)

``` sh
curl -L -O '//raw.githubusercontent.com/mulle-sde/mulle-sde/release/bin/installer-all' && \
chmod 755 installer-all && \
OTHER_PROJECTS="mulle-objc/mulle-objc-developer;latest \
mulle-c/mulle-c-developer;latest" \
SDE_PROJECTS="mulle-sde-developer;latest" ./installer-all ~
```


### Docker

There is a [Dockerfile](//raw.githubusercontent.com/mulle-objc/mulle-objc-developer/release/Dockerfile) in the project.

This will build and run an ephemeral mulle-sde container:

``` sh
docker build -t mulle-objc-developer '//raw.githubusercontent.com/mulle-objc/mulle-objc-developer/release/Dockerfile'
docker run -i -t --rm mulle-objc-developer
```

>
> To create a 32 bit docker on the base of xenial use
>
> ``` sh
>  docker build -t mulle-objc-developer-32 '//raw.githubusercontent.com/mulle-objc/mulle-objc-developer/release/i386/Dockerfile'
> docker run -i -t --rm mulle-objc-developer-32
> ```
>
> Xenial support will run out evetually though.
>

# Usage

#### Check that the (meta) extensions are found:

```
mulle-sde extension show
```

### Create an Objective-C executable project

``` sh
mkdir foo
cd foo
mulle-sde init -m mulle-objc/objc-developer executable
```

### Create an Objective-C library project

``` sh
mulle-sde init -m mulle-objc/objc-developer -d foolib library
```

### Don't create a project but get ObjC libraries built

``` sh
mulle-sde init -m mulle-objc/objc-developer none
mulle-sde craft
```

