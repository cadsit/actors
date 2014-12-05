(*
 *    File: reduction.sig
 *    Author: Connor Adsit
 *    Date: 2014-12-05
 *
 *    Specification for the reduction pattern for the map-reduce framework
 *)

signature REDUCTION =
sig
   structure Input : INPUT
   structure Output : OUTPUT

   val maxThreads : int

   val divide : Input.t list -> (Input.t list) list

   val reduce : Output.t list -> Output.t -> Output.t

   val runReduce : (Input.t -> Output.t) -> Input.t list -> Output.t
end
