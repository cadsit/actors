(*
 *    File: seq-redux-fn.sml
 *    Author: Connor Adsit
 *    Date: 2014-12-05
 *
 *    Creates a structure that is capable of performing a
 *    sequential reduction
 *)
functor SeqReduxFn (structure I : INPUT
                    structure O : OUTPUT) : REDUCTION =
struct
   structure Input = I
   structure Output = O

   val maxThreads = 1

   fun divide lst = [lst]

   val divide = divide

   fun reduce lst res = 
      List.foldl 
         (fn (item, result) => Output.combine item result)
         res 
         lst

   val reduce = reduce

   fun runReduce map lst =
      let
         val lsts = divide lst
         val lsts' = List.map (fn l => List.map map l) lsts
         val res = List.map (fn l => reduce l Output.default) lsts'
      in
         List.foldl (fn (l, r) => Output.combine l r) Output.default res
      end 

   val runReduce = runReduce
end
