(*
 *    File: reduction.sig
 *    Author: Connor Adsit
 *   
 *    Contains the type signatures for methods that must be provided
 *    by the reduction api
 *)

signature REDUCTION =
sig
   val divide : {actor: string, movie: string, ...} list -> int ->
                ({actor: string, movie: string, ...} list) chan

   val avgAge : ({actor: string, movie: string, ...} list) chan ->
                ({movie: string, totalAge: int, count: int, ...} list) chan

   val reduce : (({movie: string, totalAge: int, count: int} list) chan) list ->
                ({movie: string, totalAge: int, count: int} list) * int * int
end
