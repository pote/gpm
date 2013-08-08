#!/usr/bin/env bash
. assert.sh

# Setting up v5.0 of package
cat > Godeps <<EOF
# A comment here...
github.com/nu7hatch/gotrail v0.0.2
github.com/pote/johnny-deps-testing-package v5.0 # a comment there!

# github.com/pote/johnny-deps-testing-package v5.1
EOF

../bin/johnny_deps
assert "go run go_code.go" "v5.0"

rm Godeps
assert_end examples
