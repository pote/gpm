# Go Package Manager [![Build Status](https://travis-ci.org/pote/gpm.png?branch=master)](https://travis-ci.org/pote/gpm)

Go Package Manager (or gpm, for short) is a tool that helps achieve reproducible builds for Go applications by specifying the revision of each external Go package that the application depends on.

Being simple and unobstrusive are some of the most important design choices for gpm: `go get` already provides a way to fetch dependencies, and relies on versions control systems like Git to do it, gpm adds the additional step of setting each dependency repo to the desired revision, neither Go or your application even know about any of this happening, it just works.

To achieve this, gpm uses a manifest file which is assumed to be called `Godeps` (although you can name it however you want), running gpm fetches all dependencies and ensures each is set to a specified version, down to revision level.

## Basic usage

For a given project, running `gpm` in the directory containing the `Godeps` file is enough to make sure dependencies in the file are fetched and set to the correct revision.

However, if you share your `GOPATH` with other projects running gpm each time can get old, my solution for that is to isolate dependencies by manipulating the `GOPATH`.

You can see gpm in action under this workflow in the following gif:

![sample gpm usage](./gpm.gif)

## Installation options

### In OSX with Homebrew

```bash
$ brew install gpm
```

### In Arch Linux - AUR

```bash
$ yaourt -S go-gpm
```
or

```bash
$ packer -S go-gpm
```

Caveat: you'll use `go-gpm` instead of just `gpm` in the command line, as there is a general purpose linux package under that name already.

### Manually with a one-liner

Latest stable release:

```bash
$ wget https://raw.githubusercontent.com/pote/gpm/v1.4.0/bin/gpm && chmod +x gpm && sudo mv gpm /usr/local/bin
```

### Manually on *nix using the makefile.

```bash
$ git clone https://github.com/pote/gpm.git && cd gpm
$ git checkout v1.4.0 # You can ignore this part if you want to install HEAD.
$ ./configure
$ make install
```

### Use directly from GitHub

As gpm is a bash script you can always use it directly from GitHub via `wget` or `curl`, this is particularly useful for CI servers and other automated environments.

```bash
## With wget
$ wget -qO- https://raw.githubusercontent.com/pote/gpm/v1.4.0/bin/gpm | bash

## With cURL
$ curl -s https://raw.githubusercontent.com/pote/gpm/v1.4.0/bin/gpm | bash
```

## The Godeps file

`gpm` expects you to have a file called `Godeps` in the root of your Go application in the format `<import path> <tag/revision>`.

Once this file is in place, running the `gpm` tool will download those packages and check out the specified versions.

#### Packages

You can specify packages with the `<import path> <version>` format, where `version` can be a revision number (a git/bazaar/mercurial/svn revision hash) or a tag.

```bash
$ ls .
Godeps  foo.go  foo_test.go

$ cat Godeps
github.com/nu7hatch/gotrail               v0.0.2
github.com/replicon/fast-archiver         v1.02
launchpad.net/gocheck                     r2013.03.03   # Bazaar repositories are supported
code.google.com/p/go.example/hello/...    ae081cd1d6cc  # And so are Mercurial ones
```

When specifying your dependencies please keep in mind how gpm and the go tool operate: importing a package is setting the version of a cloned repo to a specific revision, so if you are importing several subpackages that are hosted under the same repo only one of them (the top level) should be specified in your Godeps file, in cases where there are no Go packages in the root of the dependency repository you can get Go to fetch the code anyway by appending `/...` to the import path (see last line in the example above)

#### Comments

The Godeps file accepts comments using a `#` symbol. Everything to the right of a `#` will be
ignored by gpm, as well as empty lines.

#### Extensibility

As a convention comments can be used to specify lines that gpm core should ignore but are instead intended to affect how a given [gpm plugin](#plugins) behaves.

For example: a hypothetical `gpm-track` plugin that makes sure a given package is always updated to its last possible version would leverage a line like this one:

```bash
#[gpm-track] github.com/nu7hatch/gotrail
```

This convention makes the Godeps file format extensible, just as with plugins this can help identify common needs that might later on be merged into core without having to sacrifice code simplicity in order to explore new features.

#### Private Repos

Both gpm and `go get` support using private GitHub repositories! Here's what you need to do in order for a specific machine to be able to access them:

* Generate a GitHub access token by following [these instructions](https://help.github.com/articles/creating-an-access-token-for-command-line-use/).
* Add the following line to the `~/.netrc` file in your home directory.

```bash
machine github.com login <token>
```

You can now use gpm (and `go get`) to install private repositories to which your user has access! :)

#### Completeness

Any dependency not specified in the `Godeps` file will be installed by the Go tool to whatever revision the master branch of its hosting repository is pointing at that given moment, as reproducibility is the main goal of gpm it is suggested to be exhaustive and list all your dependencies in the file, with a specific revision.

Do it once, reproduce it anytime, it pays off.

### Commands

gpm has the following commands:

```bash
$ gpm             # Same as 'install'.
$ gpm get         # Parses the Godeps file, gets dependencies and sets them
                  # to the appropriate version but does not install them.
$ gpm install     # Parses the Godeps file, installs dependencies and sets
                  # them to the appropriate version.
$ gpm version     # Outputs version information
$ gpm help        # Prints this message
```

### Plugins

As of version [v1.1.1](https://github.com/pote/gpm/releases/tag/v1.1.1) gpm supports plugins, the intent of which is the ability to add powerful non-core features to gpm without compromising the simplicity of its codebase.

The way gpm plugin works is simple: whenever an unknown command is passed into gpm it will look for an executable in your `$PATH` called `gpm-<command>` and if it exists it will run it while passing all extra arguments to it, simple yet powerful.

This brings a lot to the table: plugins can be written in anything, they can be Go binaries, bash scripts, Ruby gems, Python packages, you name it. gpm wants to make it easy for you to extend it. :)

#### Installing plugins through Homebrew

I maintain a [repository with homebrew formulae for gpm plugins](https://github.com/pote/homebrew-gpm_plugins) that you can add to your system with the `brew tap` command:

```bash
$ brew tap pote/gpm_plugins
```

After you've done this you can install plugins as you would with any other homebrew packge.

```bash
$ brew install gpm-bootstrap
```

#### Known Plugins

If you have written a gpm plugin and want it included please send a pull request to the repo! I love how people have taken to explore possible features using plugins so if you've written one there is about a 99% chance I will include it here. :)

| Name and Link                   | Author                               | Short Description                 | Type        |
|:-------------------------------:|:------------------------------------:|:----------------------------------|:-----------:|
| [gpm-bootstrap][plugin-boot]    | [pote][author-pote]                  | Creates an initial Godeps file    | official    |
| [gpm-git][plugin-git]           | [technosophos][author-technosophos]  | Git management helpers            | third party |
| [gpm-link][plugin-link]         | [elcuervo][author-elcuervo]          | Dependency vendoring              | third party |
| [gpm-local][plugin-local]       | [technosophos][author-technosophos]  | Usage of local paths for packages | third party |
| [gpm-prebuild][plugin-prebuild] | [technosophos][author-technosophos]  | Improves building performance     | third party |
| [gpm-all][plugin-all]           | [pote][author-pote]                  | Installs multiple sets of deps    | official    |
| [gpm-lock][plugin-lock]         | [zeeyang][author-zeeyang]            | Lock down dependency versions     | third party |

There is no real difference on official/third party plugins other than the willingness of the gpm core team to support each, plugins labeled as third party will be supported (or not) by their authors.

[plugin-boot]: https://github.com/pote/gpm-bootstrap
[plugin-git]: https://github.com/technosophos/gpm-git
[plugin-link]: https://github.com/elcuervo/gpm-link
[plugin-local]: https://github.com/technosophos/gpm-local
[plugin-prebuild]: https://github.com/technosophos/gpm-prebuild
[plugin-all]: https://github.com/pote/gpm-all
[plugin-lock]: https://github.com/zeeyang/gpm-lock

[author-pote]: https://github.com/pote
[author-technosophos]: https://github.com/technosophos
[author-elcuervo]: https://github.com/elcuervo
[author-zeeyang]: https://github.com/zeeyang


### Further Reading

The creator for the [gpm-git](https://github.com/technosophos/gpm-git) and [gpm-local](https://github.com/technosophos/gpm-local) and an alternative package manager called [Glide](https://github.com/masterminds/glide) wrote a [fantastic blog post explaining the usage and rationale](http://technosophos.com/2014/05/29/why-gpm-is-the-right-go-package-manager.html) of gpm, it sums up explanations for several of the design decisions behind both tools.

### Contributing

Lots of people have contributed to make gpm what it is today, if you want to take your time to play around
with the code please do so! Opening issues on bugs, feature requests or simple food for thought are a great
way to contribute, if you send a pull request please be a good citizen and do things in a tidy manner.

* Create a feature branch with a meaningful name.
* Make sure your commit messages and PR comments are informative.
* Write a test for your feature if applicable.
* Always remember to run the test suite with `make test` before comitting.

Either way, thank you **very** much for any form of contribution, even if a patch ends up not being merged
the fact that it was sent and forced us to think about it is a contribution in itself.

## License

Released under MIT License, check LICENSE file for details.

## Authorship/Inspiration/Hugs

This tool is inspired by Ruby's [dep gem](http://cyx.github.io/dep/) - authored by [@cyx](http://cyx.is/) and [@soveran](http://soveran.com/), big thanks to them and to all the contributions made by the many wonderful people in our [contributors page](https://github.com/pote/gpm/graphs/contributors).

gpm is maintained by [@pote](https://github.com/pote) and [@elcuervo](https:/github.com/elcuervo).
