(*
 *    File: reduction.sml
 *    Author: Connor Adsit
 *    Date: 2014-11-30
 *
 *    Provides an implementation for the reduction strategy
 *)

structure AvgReduction :> REDUCTION =
struct

   structure AvgAgeRedux = RR.ReductionFn (RR.AvgAge)
(* ============================================================== *)

   fun divide (set : RR.InRecord.Set.set) 
              (nt: int) 
              : RR.InRecord.Set.set list =
      let
         val items = RR.InRecord.Set.listItems set
         val numItems = RR.InRecord.Set.numItems set
         val toTake = numItems div nt
         fun take n l1 l2 = 
            if n <= 0
               then (l1, l2)
               else case l1 of
                     []     => (l1, l2)
                   | (x::xs) => take (n-1) xs (x::l2)
         fun split n lst =
            if n = 0
               then []
            else if n = 1
               then [RR.InRecord.Set.addList (RR.InRecord.Set.empty, lst)]
            else let
                   val (l1, l2) = take toTake lst []
                   val set = RR.InRecord.Set.addList (RR.InRecord.Set.empty, l2)
                 in
                   set :: (split (n-1) l1)
                 end
      in
         split nt items
      end

   val divide = divide
end
