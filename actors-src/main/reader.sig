(*
 *    File: reader.sig
 *    Author: Connor Adsit
 *    Date: 2014-12-04
 *
 *    Provides a description of a file reader
 *)

signature READER =
sig
   exception ScannerError
   exception ParseError

   structure Input : INPUT

   val scan : string -> Token.t list
   val parse : Token.t list -> Input.t list 
   val read : string -> Input.t list
end
