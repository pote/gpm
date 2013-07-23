-include ./config.make

all:
	-@echo Nothing to do...

install:
	install -d $(prefix)/bin
	install -m 0755 bin/johnny_deps $(prefix)/bin
