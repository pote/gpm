#!/usr/bin/env bash
. assert.sh

# Setting up v5.0 of package
echo "github.com/pote/johnny-deps-testing-package v5.0"   > Godeps
echo "#github.com/pote/johnny-deps-testing-package v5.1"  >> Godeps
echo "# github.com/pote/johnny-deps-testing-package v5.1" >> Godeps

../bin/johnny_deps
assert "go run go_code.go" "v5.0"

rm Godeps
assert_end examples
