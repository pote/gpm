. assert.sh

GPM=../bin/gpm
# Setting up v5.0 of package
assert_raises "$GPM install <(echo 'github.com/pote/gpm-testing-package v6.1')"
assert "go run go_code.go" "v6.1"

# Setting up v5.1 of package
assert_raises "$GPM install <(echo 'github.com/pote/gpm-testing-package v6.2')"
assert "go run go_code.go" "v6.2"

# Subpackage
version="a6a0a737c00caf4d4c2bb589941ace0d688168bb"
echo "github.com/garyburd/redigo/redis $version" > Godeps
assert_raises "$GPM"
rm Godeps
cd $GOPATH/src/github.com/garyburd/redigo
assert "git rev-parse HEAD" "$version"

assert_end examples
