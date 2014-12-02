
functor ReducerFn (structure MI : MOV_INFO
                   structure OM : ORD_MAP) : REDUCER = 
struct
   structure Info = MI
   type t = Info.t OM.map
   val reduce = (fn (res1, res2) =>
      OM.foldli
         (fn (k, r, m) => 
            case OM.find (m, k) of
               SOME r' => OM.insert (m, k, Info.combine (r, r'))
             | NONE    => OM.insert (m, k, r))
      res1
      res2)
   val toString = fn r =>
                     OM.foldl (fn (v, s) => (MI.toString v) ^ "\n" ^ s) "" r
end
