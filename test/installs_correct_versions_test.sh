. assert.sh

# Setting up v5.0 of package
echo "github.com/pote/johnny-deps-testing-package v5.0" > Godeps
../gpm
assert "go run go_code.go" "v5.0"

# Setting up v5.1 of package
echo "github.com/pote/johnny-deps-testing-package v5.1" > Godeps
../gpm
assert "go run go_code.go" "v5.1"
rm Godeps

assert_end examples
