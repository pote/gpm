. assert.sh

# Tests adding a new package to the Godeps file.
touch testGodeps
../gpm -a github.com/pote/johnny-deps-testing-package -f testGodeps
assert "echo "$?"" "0"
assert "cat testGodeps" "github.com/pote/johnny-deps-testing-package v5.1"
rm testGodeps

# Tests adding a new package to the Godeps file using its HEAD commit.
touch testGodeps
../gpm -a github.com/pote/johnny-deps-testing-package -f testGodeps -H
assert "echo "$?"" "0"
assert "cat testGodeps" "github.com/pote/johnny-deps-testing-package  6596ffa75610ea329fb6ff13ac7da289143d427b "
rm testGodeps


# Tests tring to add a duplicated package in the Godeps file
echo "github.com/pote/johnny-deps-testing-package v5.1" > testGodeps
../gpm -a github.com/pote/johnny-deps-testing-package -f testGodeps
assert "echo "$?"" "1"
assert "cat testGodeps" "github.com/pote/johnny-deps-testing-package v5.1"
rm testGodeps


assert_end examples
