MLTON          := mlton
ACTORS_EXEC    := ../bin/actors
ACTORS_MLB     := actors.mlb
MLTON_FLAGS    := -const 'Exn.keepHistory true'
SCANNER_FILES  := main/scanner.lex
PARSER_FILES   := main/parser.grm

.PHONY: all
all: $(ACTORS_EXEC) $(SCANNER_FILES) $(PARSER_FILES) scanner parser
	$(MLTON) $(MLTON_FLAGS) -output $(ACTORS_EXEC) $(ACTORS_MLB)

scanner: $(SCANNER_FILES)
	mllex $(SCANNER_FILES)

parser: $(PARSER_FILES)
	mlyacc $(PARSER_FILES)
.PHONY: clean
clean:
	rm -f $(ACTORS_EXEC)
