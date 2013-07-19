-include ./config.make

all:
	-@echo Nothing to do...

install:
	install -d $(prefix)/bin
	install bin/johnny_deps -m 0755 -t $(prefix)/bin
