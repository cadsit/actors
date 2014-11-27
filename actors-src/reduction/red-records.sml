(*
 *    File: red-records.sml
 *    Author: Connor Adsit
 *
 *
 *)

structure RedRecords :> RED_RECORDS =
struct
   structure InRecord =
   struct
      type t = {actor: string,
                movie: string}
   end

   structure OutRecord =
   struct
      type t = {movie: string,
                totalAge: int,
                count: int}
   end
end
