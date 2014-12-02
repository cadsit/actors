(*
 *    File: reducer.sig
 *    Author: Connor Adsit
 *    Date: 2014-11-30
 *
 *    Provides a description for a reducer 
 *)

signature REDUCER =
sig
   structure Info : MOV_INFO
   type t
   val reduce : (t * t) -> t 
end
