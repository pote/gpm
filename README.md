# Go Package Manager [![Build Status](https://travis-ci.org/pote/gpm.png?branch=master)](https://travis-ci.org/pote/gpm)

gpm is a minimalistic package manager for Go that leverages the power of the `go get` command and the underlying version control systems used by it to set your Go dependencies to desired versions, thus allowing easily reproducible builds in your Go projects.

Go Package Manager makes no assumptions about your dependencies and supports Git, Bazaar and Mercurial hosted Go packages, for a smoother workflow be sure to check out [gvp](https://github.com/pote/gvp) - the Go Versioning Packager which  provides dependency isolation for your projects. 

## The Godeps file

`gpm` expects you to have a file called `Godeps` in the root of your Go application in the format `<import path> <tag/revision>`.

Once this file is in place, running the `gpm` tool will download those packages and check out the specified versions.

```
$ ls .
Godeps  foo.go  foo_test.go

$ cat Godeps
github.com/nu7hatch/gotrail               v0.0.2
github.com/replicon/fast-archiver         v1.02
launchpad.net/gocheck                     r2013.03.03   # Bazaar repositories are supported
code.google.com/p/go.example/hello/...    ae081cd1d6cc  # And so are Mercurial ones

$ gpm
>> Getting package github.com/nu7hatch/gotrail
>> Getting package github.com/replicon/fast-archiver
>> Getting package launchpad.net/gocheck
>> Getting package code.google.com/p/go.example/hello/...
>> Setting github.com/nu7hatch/gotrail to version v0.0.2
>> Setting github.com/replicon/fast-archiver to version v1.02
>> Setting code.google.com/p/go.example/hello/... to version ae081cd1d6cc
>> Setting launchpad.net/gocheck to version r2013.03.03
>> All Done
```

It is recommended to keep a healthy and exhaustive `Godeps` file in the root of all Go project that use external dependencies,
this way any project includes the documentation required to be built correctly at any point in time.

## Install

You can install `gpm` like so:

    $ git clone git@github.com:pote/gpm.git && cd gpm
    $ make install

Now the `gpm` tool should be available in your system.

### Running tests

Yeap, we wrote tests for bash. f@#$% awesome.

```
$ make test
```

## License

Released under MIT License, check LICENSE file for details.

## Authorship/Inspiration/Hugs

This tool is inspired by Ruby's [dep gem](http://cyx.github.io/dep/) - authored by [@cyx](http://cyx.is/) and [@soveran](http://soveran.com/), big thanks to them and to all the contributions made by the many wonderful people in our [contributors page](https://github.com/pote/gpm/graphs/contributors).

Go Package Manager evolved from [Johnny Deps](https://github.com/VividCortex/johnny-deps), a tool I wrote for internal use of Vivid Cortex and which is now maintained by the Vivid Cortex team.
