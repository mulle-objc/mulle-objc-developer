# 🎩 mulle-objc developer kit for mulle-sde


This is a collection of [mulle-sde](//github.com/mulle-sde/mulle-sde)
*extensions* to support development of [MulleObjC](//github.com/mulle-objc)
code. As a package **mulle-objc-developer** is also a convenient way to
install mulle-sde and [mulle-clang](//github.com/Codeon-GmbH/mulle-clang).

> See the [mulle-sde Wiki](https://github.com/mulle-sde/mulle-sde/wiki) for
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


#### Debian Mulle kybernetiK and Codeon repositories

For apt installation you need to add the Mulle kybernetiK and
the Codeon debian repositories first:

```
wget -O - https://www.codeon.de/dists/codeon-pub.asc | sudo apt-key add -
echo "deb [arch=amd64] http://download.codeon.de `lsb_release -c -s` main" | sudo tee /etc/apt/sources.list.d/codeon.de-main.list > /dev/null
wget -O - "https://www.mulle-kybernetik.com/dists/debian-admin-pub.asc" | sudo apt-key add -
echo "deb [arch=all] http://www.mulle-kybernetik.com `lsb_release -c -s` main" | sudo tee "/etc/apt/sources.list.d/mulle-kybernetik.com-main.list" > /dev/null
sudo apt-get update
```


### Script

mulle-sde provides an [installer-all](https://raw.githubusercontent.com/mulle-sde/mulle-sde/release/installer-all) script to install the required commands and mulle-objc-developer itself into `/usr` or some other place.
This is suitable for environments without supported package managers:

```
curl -L -O 'https://raw.githubusercontent.com/mulle-sde/mulle-sde/release/installer-all' && \
chmod 755 installer-all && \
sudo OTHER_PROJECTS="mulle-objc/mulle-objc-developer;latest
mulle-c/mulle-c-developer;latest
mulle-sde/mulle-sde-developer;latest" ./installer-all /usr
```

You need to install [mulle-clang](//github.com/Codeon-GmbH/mulle-clang) yourself.

### Docker

There is a [Dockerfile](https://raw.githubusercontent.com/mulle-objc/mulle-objc-developer/release/Dockerfile) in the project.

This will build and run an ephemeral mulle-sde container:

```
docker build -t mulle-objc 'https://raw.githubusercontent.com/mulle-objc/mulle-objc-developer/release/Dockerfile'
docker run -i -t --rm mulle-objc
```


# Usage

#### Check that the (meta) extensions are found:

```
mulle-sde extension list
```

### Create an Objective-C executable project

```
mkdir foo
cd foo
mulle-sde init -m mulle-objc/objc-developer executable
```

### Create an Objective-C library project

```
mulle-sde init -m mulle-objc/objc-developer -d foolib library
```


