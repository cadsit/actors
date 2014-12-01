(*
 *    File: red-records.sml
 *    Author: Connor Adsit
 *    Date: 2014-11-30
 *
 *    Provides representations of data used in the parallel reduction
 *)

structure RedRecords :> RED_RECORDS =
struct

   (* 
    * Representation of the input for reduction 
    * Stores the information as a record containing:
    *    the name of the actor
    *    the name of the movie they appear in
    *    their current age
    *)
   structure InRecord =
   struct
      type t = {actor: string,
                movie: string,
                age: int}

      (* =============================================== *)
      (* Auxiliary functions for use in data collections *)
      
      (* Compares only the names of the actors *)
      val compare = (fn (r1, r2) =>
         let
            val {actor = a1, movie = _, age = _} = r1
            val {actor = a2, movie = _, age = _} = r2
         in
            String.compare (a1, a2)
         end)

      (* Two InRecords are equal if they talk about the same actor *)
      val equals = (fn (r1, r2) => compare (r1, r2) = EQUAL)

      (* Returns the hash of the actor *)
      val hash = (fn r =>
         let
            val {actor = a, movie = _, age = _} = r
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
      structure Set = RedBlackSetFn (OrdKey)
      structure Map = RedBlackMapFn (OrdKey)
      structure Tbl = HashTableFn (HashKey)
   end


(* ============================================================== *)

   (* 
    * Defines a string map to store the association between movies
    * and the ages/counts of the actors appearing in them
    *)
   structure OrdKey =
   struct
      type ord_key = string
      val compare = String.compare
   end

   structure OutRecords = RedBlackMapFn (OrdKey)

(* ============================================================== *)

   (* Describes the type of information we want out of the reduction *)
   structure AvgAge = 
   struct
      type t = {ages: int,
                count: int}

      val combine = (fn (t1, t2) =>
                     let
                        val {ages = a1, count = c1} = t1
                        val {ages = a2, count = c2} = t2
                     in
                        {ages = a1 + a2, count = c1 + c2}
                     end) 
   end
   
(* ============================================================== *)

   (* Provides an implementation for the reduction strategy *)
   functor ReductionFn (MI: MOV_INFO) = 
   struct
      structure Info = MI
      type t = Info.t OutRecords.map
      val reduce = (fn (res1, res2) =>
         OutRecords.foldli
            (fn (k, r, m) => 
               case OutRecords.find (m, k) of
                  SOME r' => OutRecords.insert (m, k, Info.combine (r, r'))
                | NONE    => OutRecords.insert (m, k, r))
         res1
         res2)
   end
end
