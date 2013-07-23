# VividCortex :: Johnny Deps

Johnny Deps is simple script we use to have barebones dependency versioning on our Go projects. We have purposely kept it to a minimum of functionality
so things like dependency resolution are outside of its scope, but it works and solves our problems regarding versioning.

Refer to [this blog post](https://vividcortex.com/blog/2013/07/18/my-wishlist-versioned-packages-in-go/) for our rationale.

![Johnny Deps](http://i.imgur.com/MuupBVC.jpg)

## Installation

To install Johnny Deps just clone the repo and then run:

    $ cd johnny_deps
    $ ./configure --prefix=/usr/local
    $ make install

Now you should get `johnny_deps` tool available in your system.

## How does it work?

Johnny Deps expects you to have a file called `Godeps` in the root of your project, in the format `<import path> <git tag>`. This obviously
relies on the git repo of the imported package to have that tag.

Sample `Godeps`
```
github.com/VividCortex/ewma       v1.0
github.com/VividCortex/robustly   v1.1
```

Once this file is in place, simply by running the `johnny_deps` script attached to this repo all those packages will be downloaded
and set to the version specified:
```
$ ls .
Godeps  foo.go  foo_test.go
$ johnny_deps
```

Note, `johnny_deps` must be run in the directory where Godeps file is located.

### Tags, branches or commit hashes

Johnny Deps relies in Git tags because it's the most human-readable format and looks nicer in the `Godeps` file, but thanks to git
being awesome we can also specify a `git branch` or a `git commit hash` in Johnny Deps, and that will work just as well, so if a particular
project you want to import doesn't use git tags for versioning you can still specify the commit you want to work with.


Another sample `Godeps`
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
