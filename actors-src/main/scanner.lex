
(*
 *    File: scanner.lex.sml
 *    Author: Connor Adsit
 *    Date: 2014-12-01
 *
 *    Lexical specification and scanner for the input files
 *)
structure Tokens = Tokens
type lexresult = Tokens.t 
type pos = int 
type svalue = Tokens.svalue
type ('a, 'b) token = ('a, 'b) Tokens.token

val eof = fn () => Tokens.EOF
val error = fn (e) => let val _ = print (e ^ "\n") in Tokens.EOF end


%%
%structure ActorLex
alpha=[A-Za-z];
digit=[0-9];
ws=[\ \t];
%%
\n       => (lex ());
{ws}+    => (lex ());
{alpha}+ => (if yytext="name" then Tokens.KW_NAME
             else if yytext = "movie" then Tokens.KW_MOVIE 
             else if yytext = "age" then Tokens.KW_AGE 
             else Tokens.Name (yytext));
{digit}+ => (Tokens.Number (List.foldl (fn(a,r) => ord(a) + 10*r) 0 (List.rev (explode yytext))));
.        => (error "Bad input file format");
