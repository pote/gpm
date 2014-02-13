. assert.sh

GPM=../bin/gpm
# Setting up v5.0 of package
echo "github.com/pote/gpm-testing-package v6.1" > Godeps
assert_raises "$GPM"
assert "go run go_code.go" "v6.1"

# Setting up v5.1 of package
echo "github.com/pote/gpm-testing-package v6.2" > Godeps
assert_raises "$GPM"
assert "go run go_code.go" "v6.2"
rm Godeps

assert_end examples
