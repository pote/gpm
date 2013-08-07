#!/usr/bin/env bash

status=0
echo ">> Now running all tests"
for test in *test.sh
do
  echo ">> Current test: $test"
  ./$test || $status=!?
done
echo ">> All Done"
exit $status
