(*
 *    File: reduction.sml
 *    Author: Connor Adsit
 *    Date: 2014-12-05
 *
 *    Runs a non-generic reduction across a set of actors
 *)
structure Reduction =
struct

   fun runReduce (set : Actor.Set.set) : AgeMap.t =
      Actor.Set.foldl 
         (fn (a, m) =>
            let
               val m' = AgeMap.singleton a
            in
               AgeMap.combine m' m
            end)
         AgeMap.StringMap.empty
         set
end
