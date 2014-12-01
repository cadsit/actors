(*
 *    File: red-records.sig 
 *    Author: Connor Adsit
 *    Date: 2014-11-30
 *
 *    Describes records used in the parallel reduction
 *)

signature RED_RECORDS =
sig
   structure InRecord :
      sig
         type t = {actor: string,
                   movie: string,
                   age: int}

         val compare : t * t -> order
         val equals : t * t -> bool
         val hash : t -> word

         structure Set : ORD_SET where type Key.ord_key = t
         structure Map : ORD_MAP where type Key.ord_key = t
         structure Tbl : MONO_HASH_TABLE where type Key.hash_key = t
      end

   structure OutRecords : ORD_MAP where type Key.ord_key = string

   structure AvgAge : MOV_INFO

   functor ReductionFn (MI: MOV_INFO) : RES_RECORD
end
