(*
 *    File: res-record.sml
 *    Author: Connor Adsit
 *    Date: 2014-11-30
 *
 *    Provides a description for a result record
 *)

signature RES_RECORD =
sig
   structure Info : MOV_INFO
   type t
   val reduce : (t * t) -> t 
end
