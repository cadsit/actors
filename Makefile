.PHONY: all
all:
	touch bin/actors
	$(MAKE) -C actors-src/

.PHONY: clean
clean:
	$(MAKE) -C actors-src/ clean
