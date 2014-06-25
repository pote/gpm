. assert.sh

GPM=../bin/gpm
# Setting up v5.0 of package
assert_raises "$GPM install <(echo 'github.com/pote/gpm-testing-package v6.1')"
assert "go run go_code.go" "v6.1"

# Setting up v5.1 of package
assert_raises "$GPM install <(echo 'github.com/pote/gpm-testing-package v6.2')"
assert "go run go_code.go" "v6.2"

assert_end examples
