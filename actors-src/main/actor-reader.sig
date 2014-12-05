signature ACTOR_READER =
sig
   exception ScannerError
   exception ParseError

   val scan : string -> Token.t list
   val parse : Token.t list -> Actor.t list
   val read : string -> Actor.t list
end
