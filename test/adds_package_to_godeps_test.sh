. assert.sh

touch testGodeps
../bin/johnny_deps -a github.com/pote/johnny-deps-testing-package -f testGodeps
assert "echo "$?"" "0"
assert "cat testGodeps" "github.com/pote/johnny-deps-testing-package v5.1"

# Cleanup
rm testGodeps
assert_end examples
