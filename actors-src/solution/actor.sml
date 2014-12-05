(*
 *    File: actor.sml
 *    Author: Connor Adsit
 *    Date: 2014-12-05
 *
 *    encapsulates an actor for the non-generic solution
 *)
structure Actor =
struct
   type t = {name: string,
             age: int,
             movie: string}

   val make = (fn (n, a, m) => {name = n, age = a, movie = m})
   val toString = (fn {name = n, age = a, movie = m} => 
      "Name: " ^ n ^ ", age: " ^ (Int.toString a) ^ ", movie: " ^ m)

   fun compare (a1, a2) =
      let
         val {name = n1, age = _, movie = _} = a1
         val {name = n2, age = _, movie = _} = a2
      in
         String.compare (n1, n2)
      end

   fun equals (a1, a2) = compare (a1, a2) = EQUAL

   structure OrdKey =
   struct
      type ord_key = t
      val compare = compare
   end

   structure Set = RedBlackSetFn(OrdKey)
   structure Map = RedBlackMapFn (OrdKey)
end
