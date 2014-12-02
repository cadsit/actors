
(*
 *    File: scanner.lex.sml
 *    Author: Connor Adsit
 *    Date: 2014-12-01
 *
 *    Lexical specification and scanner for the input files
 *)
structure Tokens = Tokens
type pos = int
type svalue = Tokens.svalue
type lexresult = (svalue, pos) Tokens.token

val pos = ref 0

val eof = fn () => Tokens.EOF
val error = fn (e) => let val _ = print (e ^ "\n") in Tokens.EOF end


%%
%structure ActorLex
alpha=[A-Za-z];
digit=[0-9];
ws=[\ \t];
%%
\n       => (pos := (!pos) + 1; lex ());
{ws}+    => (lex ());
{alpha}+ => (if yytext="name" then Tokens.KW_NAME (!pos, !pos)
             else if yytext = "movie" then Tokens.KW_MOVIE (!pos, !pos)
             else if yytext = "age" then Tokens.KW_AGE (!pos, !pos)
             else Tokens.Name (yytext, !pos, !pos));
{digit}+ => (Tokens.Number (List.foldl (fn(a,r) => ord(a) + 10*r) 0 (List.rev (explode yytext)),
                            !pos, !pos));
.        => (error "Bad input file format");
