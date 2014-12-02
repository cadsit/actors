(*
 *    File: mov-info.sig
 *    Author: Connor Adsit
 *    Date: 2014-11-30
 *
 *    Provides an interface for information about a movie
 *    and how to combine the information
 *)

signature MOV_INFO =
sig
   type t
   val combine : (t * t) -> t
end
