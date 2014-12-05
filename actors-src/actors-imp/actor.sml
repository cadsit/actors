(*
 *    File: actor.sml
 *    Author: Connor Adsit
 *    Date: 2014-12-05
 *
 *    Example of the Input interface
 *)

structure Actor : INPUT =
struct
   type t = {name: string, age: int, movie: string}

   val toString = (fn a =>
      let
         val {name = n, age = _, movie = _} = a
      in
         n
      end)

   val compare = (fn (a1, a2) =>
      let
         val {name = n1, age = _, movie = _} = a1
         val {name = n2, age = _, movie = _} = a2
      in
         String.compare (n1, n2)
      end) 

   val equals = (fn (a1, a2) => compare (a1, a2) = EQUAL)

   val hash = (fn a =>
      let
         val {name = n, age = _, movie = _} = a
      in
         HashString.hashString n
      end)

   structure OrdKey =
   struct
      type ord_key = t
      val compare = compare
   end

   structure HashKey =
   struct
      type hash_key = t
      val hashVal = hash
      val sameKey = equals
   end

   structure Set = RedBlackSetFn (OrdKey)
   structure Map = RedBlackMapFn (OrdKey)
   structure Tbl = HashTableFn (HashKey)
end
