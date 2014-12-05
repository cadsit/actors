(*
 *    File actor-reader.sml
 *    Author: Connor Adsit
 *    Date: 2014-12-04
 *
 *    Implementation for a reader that takes in an output file from
 *    the Java utility and turns it into records for reduction
 *)

structure ActorReader :> ACTOR_READER =
struct
   exception ScannerError
   exception ParseError

   (* Hand-made scanner *)
   fun scan' str toks =
      let
         val line = TextIO.inputLine str
      in case line of
         NONE   => toks
       | SOME s => 
            let
               val tok = 
                  if String.compare (s, "name\n") = EQUAL
                     then Token.name
                  else if String.compare (s, "movie\n") = EQUAL
                     then Token.movie
                  else if String.compare (s, "age\n") = EQUAL
                     then Token.age
                  else 
                     let
                        val s' = String.substring (s, 0, (size s) - 1)
                     in case Int.fromString s' of
                        SOME n => Token.num n
                      | NONE   =>Token.id s'
                     end 
            in
               scan' str (tok::toks)
            end
      end

   fun scan fil =
      let
         val str = TextIO.openIn (fil)
      in
         scan' str []
      end

   val scan = scan

   (* Home brew parsing function *)
   fun parse l toks =
      case toks of
         []           => l
       | (tok::toks') => 
            case tok of
               Token.KW_NAME => parseName l toks' ""
             | _             => raise ParseError

   and parseName l toks name =
      case toks of
         []           => raise ParseError
       | (tok::toks') => 
            case tok of
               Token.Id s => parseName' l toks' (name^s)
             | _          => raise ParseError

   and parseName' l toks name =
      case toks of
         []           => raise ParseError
       | (tok::toks') => 
            case tok of
               Token.Id s     => parseName' l toks' (name ^ s)
             | Token.KW_MOVIE => parseMov l toks' name ""
             | _              => raise ParseError

   and parseMov l toks name mov =
      case toks of
         []           => raise ParseError
       | (tok::toks') => 
            case tok of
               Token.Id s => parseMov' l toks' name (mov ^ s)
             | _          => raise ParseError

   and parseMov' l toks name mov =
      case toks of
         []           => raise ParseError
       | (tok::toks') => 
            case tok of
               Token.Id s   => parseMov' l toks' name (mov ^ s)
             | Token.KW_AGE => parseAge l toks' name mov
             | _            => raise ParseError

   and parseAge l toks name mov =
      case toks of
         []           => raise ParseError
       | (tok::toks') => 
            case tok of
               Token.Number n =>
                  let
                     val l' = ({name = name, age = n, movie = mov})
                  in
                     parse (l':: l) toks'
                  end 
             | _              => raise ParseError

   val parse = parse [] 

   val read = parse o (List.rev o scan)
end
