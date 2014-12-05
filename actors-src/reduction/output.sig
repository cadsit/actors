(*
 *    File: output.sig
 *    Author: Connor Adsit
 *    Date: 2014-12-05
 *
 *    Specification for the output of the map-reduce framework 
 *)

signature OUTPUT =
sig
   type t

   val combine : t -> t -> t

   val default : t

   val toString : t -> string
end
