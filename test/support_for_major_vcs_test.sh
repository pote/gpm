. assert.sh

echo "
# Bazaar Repos
launchpad.net/gocheck                     r2013.03.03

# Mercurial Repos
code.google.com/p/go.example/hello/...    ae081cd1d6cc

# Git Repos
github.com/nu7hatch/gotrail               v0.0.2
" > testGodeps

../gpm -f testGodeps
assert "echo "$?"" "0"
rm testGodeps

assert_end examples
