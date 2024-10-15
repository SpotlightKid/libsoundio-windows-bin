# libsoundio Windows binaries

This repository provides pre-compiled dynamic libraries for
[libsoundio](http://libsound.io/).

Currently built against version `2.0.1-7`.

Platforms supported:

- DLLs for Windows (32-bit and 64-bit)


## Build

The binaries are compiled for different platforms by
[dockcross](https://github.com/dockcross/dockcross).
To build locally, with Docker installed, run:

```
cd build/
./build-all.sh 2.0.1-7
```

The required first positional argument (`2.0.1-7` in this example) specifies
which tag/branch of the libsoundio source repository to build from.
