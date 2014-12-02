actors
======

Obtains the average age of all actors appearing in movies currently in theaters.


Running the program:
   To build, run the 'build.sh' script at the top level.
   The executable with be stored in the bin folder (./bin/actors)
   
   To run from the top level, simply ./bin/actors with one command line argument, file,
      the name of the text input file


Design:

   I approached this problem by noticing that it can easily be abstracted into a more general 
   problem that can be used to simplify a variety of problems:

      Given an arbitrary dataset, provide a reduction strategy that combines all data into
      a desired result

   Currently, there is no infrastructure in SML/NJ that provides the tools needed to carry out
   this task. My approach to this problem was to create this generalized reduction platform and
   then provide a concrete implementation for averaging the age of actors in in-theaters movies. 
   

Structure:
   
   The abstract specification files can be found in the /actors-src/reduction directory and the
   concrete representation can be found in the /actors-src/actors-imp directory.

   Everything needed to carry out the main function (such as file parsing, running the reduction)
   can be found in /actors-src/main


What actually happens when the executable is run:

   Sadly, not much. Performing I/O in any functional language is a messy problem, and
   this implementation is not spared from these issues.

   There is a lexer and a parser for an input file (assuming that information has already
   been fetched from online), but as of now, they do not currently interoperate to actually
   produce meaningful information for the reduction platform


Problems arose during development:

   SML is not as highly developed as many other languages. Reading documentation on network
   sockets amounts to reading MLton's source code for sockets


TO-DOs:

   Provide a utility to send HTML requests and parse information into a data file

   Make RED_INPUT truly generic (needed a make function to satisfy type-checking in the parser)

   Add in a parralel multithreading to the infrastructure to help manage large loads
