(*
 *    File: age-strat.sml
 *    Author: Connor Adsit
 *    Date: 2014-12-01
 *
 *    Provides a concrete reduction strategy for the 
 *)

structure AgeStrat : RED_STRAT =
struct
   type id = string

   (* =============================== *)

   (* Defines the subparts of the reduction structure *)
   structure Input = AgeInput

   structure OrdKey =
   struct
      type ord_key = string
      val compare = String.compare
   end

   structure OutputMap = RedBlackMapFn (OrdKey) 

   structure Reducer = ReducerFn (structure MI = AgeInfo structure OM = OutputMap)
end
