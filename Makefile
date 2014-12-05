.PHONY: all
all:
	$(MAKE) -C actors-src/

.PHONY: clean
clean:
	$(MAKE) -C actors-src/ clean
