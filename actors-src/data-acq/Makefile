BIN_DIR 		 := ../../bin/
CLASS_FILE	 := ../../bin/RottenTomatoesJSON.class

.PHONY: all
all: $(CLASS_FILE)

$(CLASS_FILE): RottenTomatoesJSON.java
	javac -cp .:$(BIN_DIR)json-simple-1.1.1.jar -d $(BIN_DIR) RottenTomatoesJSON.java

.PHONY: clean
clean:
	rm -f $(CLASS_FILE)
