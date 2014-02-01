-include ./config.make

all:
	-@echo Nothing to do...

install:
	install -d $(prefix)/bin
	install -m 0755 ./bin/gpm $(prefix)/bin

test:
	cd test && ./run_all_tests.sh

.PHONY: all install test
