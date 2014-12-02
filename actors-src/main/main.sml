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
         val _ = print ("File: " ^ name ^ " with args: " ^ 
                     (List.foldl (fn (a, s) => a ^ " " ^ s) "" args) ^ "\n")
         val _ = print "Under construction\n" 
      in
         OS.Process.success
      end
end
