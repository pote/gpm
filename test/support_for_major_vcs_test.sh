. assert.sh
GPM=../bin/gpm

deps=$(cat <<EOF
# Bazaar Repos
launchpad.net/gocheck                     r2013.03.03

# Mercurial Repos
code.google.com/p/go.example/hello/...    ae081cd1d6cc

# Git Repos
github.com/nu7hatch/gotrail               v0.0.2
EOF
)

$GPM install <(echo "$deps")
assert "echo "$?"" "0"

assert_end examples
