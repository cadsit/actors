(*
 *    File: age-info.sml
 *    Author: Connor Adsit
 *    Date: 2014-12-01
 *
 *    Provides a concrete implementation of a movie information record
 *    that keeps track of the accumulated ages of all actors in the movie
 *    and the count of all actors.
 *)

structure AgeInfo : MOV_INFO =
struct
   type t = {ages: int, count: int}
    
   val combine = (fn (mi1, mi2) =>
                     let
                        val {ages = a1, count = c1} = mi1
                        val {ages = a2, count = c2} = mi2
                     in
                        {ages = a1 + a2, count = c1 + c2}
                     end) 
   val toString = fn mi =>
                     let
                        val {ages = a, count = c} = mi
                     in
                        (Int.toString a) ^ (Int.toString c)
                     end
end
