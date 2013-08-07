#!/usr/bin/env bash
. assert.sh

assert "echo tabs" "spaces"
assert_end examples
