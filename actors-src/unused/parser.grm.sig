signature Actor_TOKENS =
sig
type ('a,'b) token
type svalue
val EOF:  'a * 'a -> (svalue,'a) token
val Number: (int) *  'a * 'a -> (svalue,'a) token
val Name: (String.string) *  'a * 'a -> (svalue,'a) token
val KW_AGE:  'a * 'a -> (svalue,'a) token
val KW_MOVIE:  'a * 'a -> (svalue,'a) token
val KW_NAME:  'a * 'a -> (svalue,'a) token
end
signature Actor_LRVALS=
sig
structure Tokens : Actor_TOKENS
structure ParserData:PARSER_DATA
sharing type ParserData.Token.token = Tokens.token
sharing type ParserData.svalue = Tokens.svalue
end
