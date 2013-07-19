#!/usr/bin/env bash -e

## The Godeps file is expected to have lines like so:
#
# github.com/VividCortex/robustly v2.6
#
## where the first element is the import path and the second is a tag
## in the project.

while read dependency; do
  x=( $dependency )
  package=${x[0]}
  version=${x[1]}
  go get -u -v $package
  echo "Setting Go Package: $package to version $version"
  cd $GOPATH/src/$package && git checkout $version && echo "Done"
done < Godeps
