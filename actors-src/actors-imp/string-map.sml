(*
 *    File: string-map.sml
 *    Author: Connor Adsit
 *    Date: 2014-12-05
 *
 *    Auxiliary data types for the average actor age reducer
 *)

structure StringKey =
struct
   type ord_key = string
   val compare = String.compare
end

structure StringMap = RedBlackMapFn (StringKey)
