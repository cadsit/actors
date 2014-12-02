(*
 *    File: reduction.sig
 *    Author: Connor Adsit
 *   
 *    Contains the type signatures for methods that must be provided
 *    by the reduction api
 *)

signature REDUCTION =
sig
   structure RS : RED_STRAT

   val eval : RS.Input.t -> RS.Reducer.t

   val divide : RS.Input.Set.set -> int -> RS.Input.Set.set list

   val runReduce : RS.Input.Set.set -> int -> RS.Reducer.Info.t RS.OutputMap.map
end
