(* 
 *    File: main.sml
 *    Author: Connor Adsit
 *    Date: 2014-12-01
 *
 *    Uses the generic map-reduce framework to perform
 *    a reduction on the average age of actors
 *)
structure Main : 
sig
   val runMain : string * string list -> OS.Process.status
end  =

struct
   exception InvalidArgs

   fun map (a: Actor.t) =
      let
         val {name = n, age = c, movie = m }= a
      in
         StringMap.insert (StringMap.empty, m, {ages=c, count = 1})
      end

   structure Reduction = SeqReduxFn (structure I = Actor structure O = AvgAgeByMovie)

   val runMain = fn (name, args) =>
      let
         val (file, args') = case args of
                              (f::ars) => (f, ars)
                            | _       => raise InvalidArgs
         val recs = ActorReader.read file
         val res = Reduction.runReduce map recs
         val _ = print (AvgAgeByMovie.toString res)
      in
         OS.Process.success
      end
end
