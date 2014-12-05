(*
 *    File: avg-age-by-movie.sml
 *    Author: Connor Adsit
 *    Date: 2014-12-05
 *
 *    Example of the Output interface
 *)

structure AvgAgeByMovie : OUTPUT =
struct
   type mean = {ages: int, count: int}

   type t = mean StringMap.map

   (* Insert new data into the map if we haven't seen the movie before
    * or aggregate total ages and counts *)
   fun combine rec1 rec2 =
      StringMap.foldli 
         (fn (k,v,r) =>
            case StringMap.find (r, k) of
               NONE    => StringMap.insert (r, k, v) 
             | SOME v' => 
                  let
                     val {ages = a1, count = c1} = v
                     val {ages = a2, count = c2} = v'
                     val v'' = {ages = a1 + a2, count = c1 + c2}
                  in
                     StringMap.insert (r, k, v'')
                  end)
         rec2
         rec1

   val combine = combine

   val default = StringMap.empty

   (* Print-friendly results*)
   fun toString m =
      let
         val (num, denom, str) = 
            StringMap.foldli
               (fn (k, v, (n,d, s)) => 
                  let
                     val {ages = a, count = c} = v
                     val s' = s ^ "The average age for the movie " ^ k ^ " was " ^ (Int.toString (a div c)) ^ "\n"
                  in
                     (n+a, d+c, s')
                  end)
               (0,0, "")
               m
      in
         str ^ "The total average age for all actors currently in theaters is: " ^ (Int.toString (num div denom)) ^ "\n"
      end

   val toString = toString
end
