#!/usr/bin/env bash
. assert.sh
GPM=../bin/gpm

# Setting up v5.0 of package
cat > Godeps <<EOF
# A comment here...
github.com/nu7hatch/gotrail v0.0.2
github.com/pote/gpm-testing-package v6.1 # a comment there!

# github.com/pote/gpm-testing-package v6.2
EOF

$GPM
assert "go run go_code.go" "v6.1"

rm Godeps
assert_end examples
