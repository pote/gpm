#!/usr/bin/env bash

echo ">> Now running all tests"
for test in *test.sh
do
  echo ">> Current test: $test"
  ./$test
done
echo ">> All Done"
