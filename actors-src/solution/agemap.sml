(*
 *    File: agemap.sml
 *    Author: Connor Adsit
 *    Date: 2014-12-05
 *
 *    Holds a mapping between a movie and the average age of its actors
 *)
structure AgeMap = 
struct
   structure OrdKey = 
   struct 
      type ord_key = string
      val compare = String.compare
   end

   structure StringMap = RedBlackMapFn (OrdKey)

   type t = AgeInfo.t StringMap.map


   fun singleton (a: Actor.t) : t =
      let
         val {name = _, age = c, movie = m} = a
      in
         StringMap.insert (StringMap.empty, m, {ages = c, count = 1})
      end

   fun combine (m1 : t) (m2 : t) : t =
      StringMap.foldli 
         (fn (k, v, m) =>
            case StringMap.find (m, k) of
               SOME info => m
             | NONE => StringMap.insert (m, k, v))
         m2
         m1

   fun avgAge (m : t) : int =
      let
         val (num, denom) = 
            StringMap.foldli 
               (fn (k, a, (n, d)) =>
                  let
                     val {ages = x, count = y} = a
                     val _ = print ("The average age for " ^ k ^ " was " ^ (Int.toString (x div y)) ^ "\n")
                  in
                     (n + x, d + y)
                  end)
               (0,0)
               m
      in
         num div denom
      end
end
