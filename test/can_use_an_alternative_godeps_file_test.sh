. assert.sh

GPM=../bin/gpm

# Standard gpm usage
rm -rf $GOPATH/src/github.com/pote/gpm-testing-package
echo "github.com/pote/gpm-testing-package v6.1" > Godeps
assert_raises $GPM
assert "go run go_code.go" "v6.1"

rm Godeps

# Setting up v5.0 of package
rm -rf $GOPATH/src/github.com/pote/gpm-testing-package
echo "github.com/pote/gpm-testing-package v6.1" > Godeps.prod
assert_raises "$GPM install Godeps.prod"
assert "go run go_code.go" "v6.1"

rm Godeps.prod

assert_end examples
