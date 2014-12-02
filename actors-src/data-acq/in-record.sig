(*
 *    File: in-record.sig
 *    Author: Connor Adsit
 *    Date 2014-12-01
 *
 *    Provides a specification for an input to the reduction framework
 *)

signature IN_RECORD =
sig
   type t

   val compare : t * t -> order
   val equals : t * t -> bool
   val hash : t -> word

   val make : (string * int *string) -> t

   structure Set : ORD_SET where type Key.ord_key = t
   structure Map : ORD_MAP where type Key.ord_key = t
   structure Tbl : MONO_HASH_TABLE where type Key.hash_key = t
end
