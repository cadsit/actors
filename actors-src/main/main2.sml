(* 
 *    File: main.sml
 *    Author: Connor Adsit
 *    Date: 2014-12-01
 *
 *i
 *)
structure Main : 
sig
   val runMain : string * string list -> OS.Process.status
end  =

struct
   exception InvalidArgs
   val runMain = fn (name, args) =>
      let
         val (file, args') = case args of
                              (f::ars) => (f, ars)
                            | _       => raise InvalidArgs
         val recs = ActorReader.read file
         val res = Reduction.runReduce (Actor.Set.fromList recs)
         val _ = print ("Result of the reduction is: " ^ (Int.toString (AgeMap.avgAge res)) ^ "\n")
      in
         OS.Process.success
      end
end
