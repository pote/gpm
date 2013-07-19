-include ./config.make

all:
	-@echo Nothing to do...

install:
	install -d $(prefix)/bin
	install bin/godeps.sh -m 0755 -t $(prefix)/bin
