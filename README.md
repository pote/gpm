# Go Package Manager [![Build Status](https://travis-ci.org/pote/hashifiable.png?branch=master)](https://travis-ci.org/pote/gpm)

The `gpm` tool provides a simple way to get a reproducible Go dependency tree with a simple command. This is inspired by tools such as Python's [pip](http://www.pip-installer.org/) or Ruby's [dep](http://cyx.github.io/dep/)


## The Godeps file

`gpm` expects you to have a file called `Godeps` in the root of your project, in the format `<import path> <git tag>`.

Here's a sample `Godeps` file:

```
github.com/nu7hatch/gotrail         v0.0.2
github.com/replicon/fast-archiver   v1.02
```

Once this file is in place, running the `gpm` tool will download those packages
and check out the version specified:

```
$ ls .
Godeps  foo.go  foo_test.go
$ gpm
```

When called without arguments `gpm` looks for the Godeps file in the execution directory.

It is recommended to keep a healthy and exhaustive `Godeps` file in the root of all Go project that use external dependencies,
this way any project includes the documentation required to be built correctly at any point in time.

### Tags or commit hashes

`gpm` encourages the use of Git tags on your `Godeps` file due to them being
the most human-readable format, but thanks to git being awesome we can also 
specify a commit SHA and that will work just as well.

So if a particular project you want to import doesn't use git tags for versioning,
you can still specify the commit you want to work with. Under the hood, we use
`git checkout <tag>`, so anything `git` accepts for that argument will work.

Another sample `Godeps` with a branch and a commit SHA:

```
github.com/replicon/fast-archiver   v1.02
github.com/nu7hatch/gotrail         2eb79d1f03ab24bacbc32b15b75769880629a865

# TODO: This is a comment! :)
```

#### Something you absolutely shouldn't do

Because `gpm` uses `git checkout <version>` to set the version of each package, you can technically specify a branch there, like `master` or `develop` or whatever. This is a very bad idea.

The assumption that's made is that the versions in the `Godeps` file are immutable, this way we avoid needing a `Godeps.lock` file like [Ruby's Bundler](http://bundler.io/), you *can* ignore this rule, but be aware that you are doing so at your own peril and that we think you are a very bad person for doing this.

## Usage

You can run `gpm` directly from the web or install it locally.

### Run without installing it

You can run `gpm` specifying a tagged version, like so:

```
$ curl -s https://raw.github.com/pote/gpm/v0.3.1/gpm | bash
```

### Install it locally

To install `gpm` just clone the repo and then run:

    $ git clone git@github.com:pote/gpm.git
    $ cd gpm
    $ ./configure --prefix=/usr/local
    $ make install

Now the `gpm` tool should be available in your system.

### Usage Options

The following flags can be passed to the `gpm` tool:

```
    -f <path/to/file>               - by default gpm will look at the directory you are running gpm from, but you can
                                      specify a file.
    
    -a <package import path>        - retrieves latest release (git tag) from the project's page and adds it to the
                                      Godeps file.
    
    -H                              - used along with -a, instead of the latest release only the latest commit SHA
                                      is added to the Godeps file.

```


### Running tests

Yeap, we wrote tests for bash. f@#$% yeah!

```
$ make test
```

## License

Released under MIT License, check LICENSE file for details.

## Authorship/Inspiration/Hugs

This tool is inspired by Ruby's [dep gem](http://cyx.github.io/dep/) - authored by [@cyx](http://cyx.is/) and [@soveran](http://soveran.com/), big thanks to them and to all the contributions made by the many wonderful people in our [contributors page](https://github.com/pote/gpm/graphs/contributors).

Go Package Manager evolved from [Johnny Deps](https://github.com/VividCortex/johnny-deps), a tool I wrote for internal use of Vivid Cortex and which is maintained by the Vivid Cortex team.
