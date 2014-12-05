MLTON          := mlton
ACTORS_EXEC    := ../bin/actors
ACTORS_MLB     := actors.mlb
MLTON_FLAGS    := -const 'Exn.keepHistory true'
SCANNER_FILES  := main/scanner.lex
SCANNER_GEN    := main/scanner.lex.sml
PARSER_FILES   := main/parser.grm
PARSER_GEN     := main/parser.grm.sml


.PHONY: all
all: $(ACTORS_EXEC) 
	$(MAKE) -C data-acq/
	$(MLTON) $(MLTON_FLAGS) -output $(ACTORS_EXEC) $(ACTORS_MLB)

.PHONY: clean
clean:
	$(MAKE) -C data-acq/ clean
	rm -f reduction/sources
	rm -f actors-imp/sources
	rm -f main/sources
	rm -f $(ACTORS_EXEC)
