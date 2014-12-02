(*
 *    File: reduction.sml
 *    Author: Connor Adsit
 *    Date: 2014-11-30
 *
 *    Provides an implementation for the reduction strategy
 *)

structure AvgReduction :> REDUCTION =
struct
   structure AI = AgeInput
   structure RS = AgeStrat

   (* ===================================== *)
   
   (* Functions required to run the reducer *)
   fun eval (inp : RS.Input.t) : RS.Reducer.t =
      let
         val AI.Actor {actor = n, age = a, movie = m} = inp
         val out = {ages = a, count = 1}
         val map = RS.OutputMap.insert (RS.OutputMap.empty, m, out)
      in
         map
      end 

   val eval = eval

   fun divide (set : RS.Input.Set.set) 
              (nt: int) 
              : RS.Input.Set.set list =
      let
         val items = RS.Input.Set.listItems set
         val numItems = RS.Input.Set.numItems set
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
               then [RS.Input.Set.addList (RS.Input.Set.empty, lst)]
            else let
                   val (l1, l2) = take toTake lst []
                   val set = RS.Input.Set.addList (RS.Input.Set.empty, l2)
                 in
                   set :: (split (n-1) l1)
                 end
      in
         split nt items
      end

   val divide = divide

   fun runReduce inSet n = 
      let
         val mapped = RS.Input.Set.foldl (fn (x, l) => (eval x)::l) [] inSet
      in
         List.foldl (fn (x, r) => RS.Reducer.reduce (x, r)) RS.OutputMap.empty mapped
      end

   val runReduce = runReduce
end
