# VividCortex :: Godeps

## TL;DR

Godeps is simple script we use to have barebones dependency versioning on our Go projects. We have purposely kept it to a minimum of functionality
so things like dependency resolution are outside of its scope, but it works and solves our problems regarding versioning.

Refer to [this blog post](https://vividcortex.com/blog/2013/07/18/my-wishlist-versioned-packages-in-go/) for our rationale.

## How does it work?

Godeps expects you to have a file called `Godeps` in the root of your project, in the format `<import path> <git tag version>`

Sample `Godeps`
```
github.com/VividCortex/ewma       v1.0
github.com/VividCortex/robustly   v1.1
```

Once this file is in place, simply by running the `godeps.sh` script attached to this repo all those packages will be downloaded
and set to the version specified.


## And one more thing

Godeps relies in Git tags because it's the most human-readable format and looks nicer in the `Godeps` file, but thanks to git
being awesome we can also specify a `git branch` or a `git commit hash` in Godeps, and that will work just as well.


Another sample Godeps:
```
github.com/VividCortex/ewma       v1.0
github.com/VividCortex/robustly   master
github.com/nu7hatch/gotrail       2eb79d1f03ab24bacbc32b15b75769880629a865
```
