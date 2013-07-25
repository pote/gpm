# Johnny Deps

We wrote Johnny Deps to provide barebones dependency versioning on our Go projects. We have purposely kept it to a minimum of functionality
so things like dependency resolution are outside of its scope, but it works and solves our problems regarding versioning.

Refer to [this blog post](https://vividcortex.com/blog/2013/07/18/my-wishlist-versioned-packages-in-go/) for our rationale. The major need we have is reproducible builds: we want to be able to freeze a build's dependencies so we can re-fetch exactly the specified versions later and build exactly the same binary, and we want the specification of dependencies to be included in the source code itself. Johnny Deps does that for us, encoding dependencies and their versions in a `Godeps` file.

![Johnny Deps](http://i.imgur.com/MuupBVC.jpg)

## Installation

To install Johnny Deps just clone the repo and then run:

    $ cd johnny_deps
    $ ./configure --prefix=/usr/local
    $ make install

Now the `johnny_deps` tool should be available in your system.

## How does it work?

Johnny Deps expects you to have a file called `Godeps` in the root of your project, in the format `<import path> <git tag>`. More on this later.

Here's a sample `Godeps` file:

```
github.com/VividCortex/ewma       v1.0
github.com/VividCortex/robustly   v1.1
```

Once this file is in place, running the `johnny_deps` script will download those packages
and check out the version specified:

```
$ ls .
Godeps  foo.go  foo_test.go
$ johnny_deps
```

Note, `johnny_deps` must be run in the directory where the `Godeps` file is located.

### Tags, branches or commit hashes

Johnny Deps suggests (and we usually use) Git tags because it's the most
human-readable format and looks nicer in the `Godeps` file, but thanks to git
being awesome we can also specify a branch or a SHA, and that will work just as well.
So if a particular project you want to import doesn't use git tags for versioning,
you can still specify the commit you want to work with. Under the hood, we use
`git checkout <tag>`, so anything `git` accepts for that argument will work.

Another sample `Godeps` with a branch and a SHA:

```
github.com/VividCortex/ewma       v1.0
github.com/VividCortex/robustly   master
github.com/nu7hatch/gotrail       2eb79d1f03ab24bacbc32b15b75769880629a865
```

## Contributing

1. Fork the project.
2. Write awesome code (in a feature branch).
3. Test, test, test...!
4. Commit, push and send Pull Request.

## License

Copyright (c) 2013 VividCortex.
Released under MIT License, check LICENSE file for details.

## Inspiration

`Johnny_Deps` was inspired by Ruby's [dep gem](http://cyx.github.io/dep/) and the design philosophies of [@cyx](http://cyx.is/) and [@soveran](http://soveran.com/), big thanks to them.
