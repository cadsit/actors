(*
 *    File: reduction.sig
 *    Author: Connor Adsit
 *   
 *    Contains the type signatures for methods that must be provided
 *    by the reduction api
 *)

signature REDUCTION =
sig
   structure RR : RED_RECORDS
   structure AvgAgeRedux : RES_RECORD 
   val divide : RedRecords.InRecord.Set.set -> int -> RedRecords.InRecord.Set.set list

(*
   val avgAge : RedRecords.InRecord.Set.set list -> AvgAgeRedux.t list
*)
end
