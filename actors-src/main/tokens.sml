structure Tokens =
struct
   datatype t =
      KW_NAME 
    | KW_MOVIE
    | KW_AGE
    | Name of string
    | Number of int
    | EOF
   type svalue = t
   type ('a, 'b) token = t
end
