
(* Inner representation of a token *)
structure Token =
struct
   datatype t = 
      KW_NAME
    | KW_MOVIE
    | KW_AGE
    | Number of int
    | Id of string

   val name = KW_NAME
   val movie = KW_MOVIE
   val age = KW_AGE
   val num = (fn n => Number n)
   val id = (fn s => Id s)
     val toString = (fn tok =>
      case tok of
         KW_NAME  => "KW_NAME"
       | KW_MOVIE => "KW_MOVIE"
       | KW_AGE   => "KW_AGE"
       | Number i => "Number " ^ (Int.toString i)
       | Id s     => "Id " ^ s)
end
