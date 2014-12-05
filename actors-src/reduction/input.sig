(* 
 *    File: input.sig
 *    Author: Connor Adsit
 *    Date: 2014-12-05
 *
 *    Specification for an input into the map-reduce framework
 *)

signature INPUT =
sig
   type t

   val toString : t -> string
   val compare : (t * t) -> order
   val equals : (t * t) -> bool 
   val hash : t -> word

   structure Set : ORD_SET where type Key.ord_key = t
   structure Map : ORD_MAP where type Key.ord_key = t
   structure Tbl : MONO_HASH_TABLE where type Key.hash_key = t
end
