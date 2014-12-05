(*
 *    File: ageinfo.sml
 *    Author: Connor Adsit
 *    Date: 2014-12-05
 *
 *    Encapsulates the reduced information for the non-generic solution
 *)

structure AgeInfo =
struct
   type t = {ages: int, count: int}

   fun combine ai1 ai2 =
      let
         val {ages = a1, count = c1} = ai1
         val {ages = a2, count = c2} = ai2
      in
         {ages = a1 + a2, count = c1 + c2}
      end

   val toString = (fn ai =>
      let
         val {ages = a, count = c} = ai
      in
         "Ages: " ^ (Int.toString a) ^ ", Count: " ^ (Int.toString c)
      end)
end
