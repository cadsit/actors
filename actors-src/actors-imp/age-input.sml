(*
 *    File: age-input.sml
 *    Author: Connor Adsit
 *    Date 2014-12-01
 *
 *    Provides a concrete implementation of an input record used in the average age
 *    problem
 *)

structure AgeInput :> IN_RECORD =
struct
   datatype t = Actor of {actor: string,
                          age: int,
                          movie: string}


   (* =============================================== *)
   (* Auxiliary functions for use in data collections *)
   
   (* Compares only the names of the actors *)
   val compare = (fn (r1, r2) =>
      let
         val Actor {actor = a1, movie = _, age = _} = r1
         val Actor {actor = a2, movie = _, age = _} = r2
      in
         String.compare (a1, a2)
      end)

   (* Two AgeInputs are equal if they talk about the same actor *)
   val equals = (fn (r1, r2) => compare (r1, r2) = EQUAL)

   (* Returns the hash of the actor *)
   val hash = (fn r =>
      let
         val Actor {actor = a, movie = _, age = _} = r
      in
         HashString.hashString a
      end)

   (* =============================================== *)
   (* Structures used to create Set, Map and HashTable representations *)
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

   val make = fn (x, y, z) => Actor {actor = x, age = y, movie = z}
   val toString = fn ai =>
                  let
                     val Actor {actor = a, age = c, movie = m} = ai
                  in
                     a ^ (Int.toString c) ^ m
                  end
   structure Set = RedBlackSetFn (OrdKey)
   structure Map = RedBlackMapFn (OrdKey)
   structure Tbl = HashTableFn (HashKey)
end
