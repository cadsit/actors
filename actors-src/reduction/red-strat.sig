(*
 *    File: red-strat.sig 
 *    Author: Connor Adsit
 *    Date: 2014-11-30
 *
 *    Describes records used in the parallel reduction
 *)

signature RED_STRAT =
sig
   type id

   structure Input : IN_RECORD

   structure OutputMap : ORD_MAP where type Key.ord_key = id 

   structure Reducer : REDUCER
end
