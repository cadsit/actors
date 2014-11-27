(*
 *    File: red-records.sig 
 *    Author: Connor Adsit
 *
 *    Describes records used in the parallel reduction
 *)

signature RED_RECORDS =
sig
   structure InRecord :
      sig
         type t  = {actor: string,
                    movie: string}
      end

   structure OutRecord :
      sig
         type t = {movie: string,
                   totalAge: int,
                   count: int}

         val reduce : OutRecord.t -> OutRecord.t list -> OutRecord.t list
      end
end
