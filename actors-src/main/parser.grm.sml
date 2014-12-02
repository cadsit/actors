functor ActorLrValsFun(structure Token : TOKEN)
 : sig structure ParserData : PARSER_DATA
       structure Tokens : Actor_TOKENS
   end
 = 
struct
structure ParserData=
struct
structure Header = 
struct
(*#line 1.2 "parser.grm"*)
(*#line 12.1 "parser.grm.sml"*)
end
structure LrTable = Token.LrTable
structure Token = Token
local open LrTable in 
val table=let val actionRows =
"\
\\001\000\001\000\026\000\006\000\026\000\000\000\
\\001\000\001\000\032\000\006\000\032\000\000\000\
\\001\000\001\000\006\000\000\000\
\\001\000\001\000\006\000\006\000\025\000\000\000\
\\001\000\002\000\027\000\003\000\027\000\000\000\
\\001\000\002\000\028\000\003\000\028\000\000\000\
\\001\000\002\000\029\000\003\000\029\000\004\000\018\000\000\000\
\\001\000\002\000\030\000\000\000\
\\001\000\002\000\008\000\000\000\
\\001\000\003\000\031\000\000\000\
\\001\000\003\000\014\000\000\000\
\\001\000\004\000\012\000\000\000\
\\001\000\005\000\019\000\000\000\
\\001\000\006\000\000\000\000\000\
\\001\000\006\000\022\000\000\000\
\\001\000\006\000\023\000\000\000\
\\001\000\006\000\024\000\000\000\
\"
val actionRowNumbers =
"\002\000\008\000\003\000\014\000\
\\011\000\010\000\011\000\003\000\
\\015\000\007\000\006\000\000\000\
\\012\000\009\000\016\000\004\000\
\\006\000\001\000\005\000\013\000"
val gotoT =
"\
\\001\000\019\000\002\000\003\000\004\000\002\000\008\000\001\000\000\000\
\\009\000\005\000\000\000\
\\003\000\008\000\004\000\007\000\008\000\001\000\000\000\
\\000\000\
\\005\000\009\000\000\000\
\\010\000\011\000\000\000\
\\005\000\013\000\000\000\
\\003\000\014\000\004\000\007\000\008\000\001\000\000\000\
\\000\000\
\\000\000\
\\006\000\015\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\006\000\018\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\"
val numstates = 20
val numrules = 11
val s = ref "" and index = ref 0
val string_to_int = fn () => 
let val i = !index
in index := i+2; Char.ord(String.sub(!s,i)) + Char.ord(String.sub(!s,i+1)) * 256
end
val string_to_list = fn s' =>
    let val len = String.size s'
        fun f () =
           if !index < len then string_to_int() :: f()
           else nil
   in index := 0; s := s'; f ()
   end
val string_to_pairlist = fn (conv_key,conv_entry) =>
     let fun f () =
         case string_to_int()
         of 0 => EMPTY
          | n => PAIR(conv_key (n-1),conv_entry (string_to_int()),f())
     in f
     end
val string_to_pairlist_default = fn (conv_key,conv_entry) =>
    let val conv_row = string_to_pairlist(conv_key,conv_entry)
    in fn () =>
       let val default = conv_entry(string_to_int())
           val row = conv_row()
       in (row,default)
       end
   end
val string_to_table = fn (convert_row,s') =>
    let val len = String.size s'
        fun f ()=
           if !index < len then convert_row() :: f()
           else nil
     in (s := s'; index := 0; f ())
     end
local
  val memo = Array.array(numstates+numrules,ERROR)
  val _ =let fun g i=(Array.update(memo,i,REDUCE(i-numstates)); g(i+1))
       fun f i =
            if i=numstates then g i
            else (Array.update(memo,i,SHIFT (STATE i)); f (i+1))
          in f 0 handle Subscript => ()
          end
in
val entry_to_action = fn 0 => ACCEPT | 1 => ERROR | j => Array.sub(memo,(j-2))
end
val gotoT=Array.fromList(string_to_table(string_to_pairlist(NT,STATE),gotoT))
val actionRows=string_to_table(string_to_pairlist_default(T,entry_to_action),actionRows)
val actionRowNumbers = string_to_list actionRowNumbers
val actionT = let val actionRowLookUp=
let val a=Array.fromList(actionRows) in fn i=>Array.sub(a,i) end
in Array.fromList(map actionRowLookUp actionRowNumbers)
end
in LrTable.mkLrTable {actions=actionT,gotos=gotoT,numRules=numrules,
numStates=numstates,initialState=STATE 0}
end
end
local open Header in
type pos = IntInf.int
type arg = unit
structure MlyValue = 
struct
datatype svalue = VOID | ntVOID of unit ->  unit | Number of unit ->  (int) | Name of unit ->  (String.string) | Age of unit ->  (int) | MovieName of unit ->  (String.string) | ActorName of unit ->  (String.string) | Word of unit ->  (String.string) | WordsStar of unit ->  (String.string) | WordsPlus of unit ->  (String.string) | Line of unit ->  (AgeInput.t) | LineStar of unit ->  (AgeInput.t list) | LinePlus of unit ->  (AgeInput.t list) | Data of unit ->  (AgeInput.t list)
end
type svalue = MlyValue.svalue
type result = AgeInput.t list
end
structure EC=
struct
open LrTable
infix 5 $$
fun x $$ y = y::x
val is_keyword =
fn _ => false
val preferred_change : (term list * term list) list = 
nil
val noShift = 
fn (T 5) => true | _ => false
val showTerminal =
fn (T 0) => "KW_NAME"
  | (T 1) => "KW_MOVIE"
  | (T 2) => "KW_AGE"
  | (T 3) => "Name"
  | (T 4) => "Number"
  | (T 5) => "EOF"
  | _ => "bogus-term"
local open Header in
val errtermvalue=
fn _ => MlyValue.VOID
end
val terms : term list = nil
 $$ (T 5) $$ (T 2) $$ (T 1) $$ (T 0)end
structure Actions =
struct 
exception mlyAction of int
local open Header in
val actions = 
fn (i392,defaultPos,stack,
    (()):arg) =>
case (i392,stack)
of  ( 0, ( ( _, ( MlyValue.LinePlus LinePlus1, LinePlus1left, LinePlus1right)) :: rest671)) => let val  result = MlyValue.Data (fn _ => let val  (LinePlus as LinePlus1) = LinePlus1 ()
 in ((*#line 35.16 "parser.grm"*)LinePlus(*#line 167.1 "parser.grm.sml"*)
)
end)
 in ( LrTable.NT 0, ( result, LinePlus1left, LinePlus1right), rest671)
end
|  ( 1, ( ( _, ( MlyValue.LineStar LineStar1, _, LineStar1right)) :: ( _, ( MlyValue.Line Line1, Line1left, _)) :: rest671)) => let val  result = MlyValue.LinePlus (fn _ => let val  (Line as Line1) = Line1 ()
 val  (LineStar as LineStar1) = LineStar1 ()
 in ((*#line 38.21 "parser.grm"*)Line :: LineStar(*#line 173.1 "parser.grm.sml"*)
)
end)
 in ( LrTable.NT 1, ( result, Line1left, LineStar1right), rest671)
end
|  ( 2, ( ( _, ( MlyValue.LineStar LineStar1, _, LineStar1right)) :: ( _, ( MlyValue.Line Line1, Line1left, _)) :: rest671)) => let val  result = MlyValue.LineStar (fn _ => let val  (Line as Line1) = Line1 ()
 val  (LineStar as LineStar1) = LineStar1 ()
 in ((*#line 41.21 "parser.grm"*)Line :: LineStar(*#line 180.1 "parser.grm.sml"*)
)
end)
 in ( LrTable.NT 2, ( result, Line1left, LineStar1right), rest671)
end
|  ( 3, ( rest671)) => let val  result = MlyValue.LineStar (fn _ => ((*#line 42.7 "parser.grm"*) [] (*#line 187.1 "parser.grm.sml"*)
))
 in ( LrTable.NT 2, ( result, defaultPos, defaultPos), rest671)
end
|  ( 4, ( ( _, ( MlyValue.Age Age1, _, Age1right)) :: ( _, ( MlyValue.MovieName MovieName1, _, _)) :: ( _, ( MlyValue.ActorName ActorName1, ActorName1left, _)) :: rest671)) => let val  result = MlyValue.Line (fn _ => let val  (ActorName as ActorName1) = ActorName1 ()
 val  (MovieName as MovieName1) = MovieName1 ()
 val  (Age as Age1) = Age1 ()
 in ((*#line 45.31 "parser.grm"*)AgeInput.make (ActorName, Age, MovieName)(*#line 191.1 "parser.grm.sml"*)
)
end)
 in ( LrTable.NT 3, ( result, ActorName1left, Age1right), rest671)
end
|  ( 5, ( ( _, ( MlyValue.WordsStar WordsStar1, _, WordsStar1right)) :: ( _, ( MlyValue.Name Name1, Name1left, _)) :: rest671)) => let val  result = MlyValue.WordsPlus (fn _ => let val  (Name as Name1) = Name1 ()
 val  (WordsStar as WordsStar1) = WordsStar1 ()
 in ((*#line 48.22 "parser.grm"*)Name ^ WordsStar(*#line 199.1 "parser.grm.sml"*)
)
end)
 in ( LrTable.NT 4, ( result, Name1left, WordsStar1right), rest671)
end
|  ( 6, ( ( _, ( MlyValue.WordsStar WordsStar1, _, WordsStar1right)) :: ( _, ( MlyValue.Name Name1, Name1left, _)) :: rest671)) => let val  result = MlyValue.WordsStar (fn _ => let val  (Name as Name1) = Name1 ()
 val  (WordsStar as WordsStar1) = WordsStar1 ()
 in ((*#line 51.22 "parser.grm"*)Name ^ WordsStar(*#line 206.1 "parser.grm.sml"*)
)
end)
 in ( LrTable.NT 5, ( result, Name1left, WordsStar1right), rest671)
end
|  ( 7, ( rest671)) => let val  result = MlyValue.WordsStar (fn _ => ((*#line 52.7 "parser.grm"*) "" (*#line 213.1 "parser.grm.sml"*)
))
 in ( LrTable.NT 5, ( result, defaultPos, defaultPos), rest671)
end
|  ( 8, ( ( _, ( MlyValue.WordsPlus WordsPlus1, _, WordsPlus1right)) :: ( _, ( _, KW_NAME1left, _)) :: rest671)) => let val  result = MlyValue.ActorName (fn _ => let val  (WordsPlus as WordsPlus1) = WordsPlus1 ()
 in ((*#line 55.25 "parser.grm"*)WordsPlus(*#line 217.1 "parser.grm.sml"*)
)
end)
 in ( LrTable.NT 7, ( result, KW_NAME1left, WordsPlus1right), rest671)
end
|  ( 9, ( ( _, ( MlyValue.WordsPlus WordsPlus1, _, WordsPlus1right)) :: ( _, ( _, KW_MOVIE1left, _)) :: rest671)) => let val  result = MlyValue.MovieName (fn _ => let val  (WordsPlus as WordsPlus1) = WordsPlus1 ()
 in ((*#line 58.26 "parser.grm"*)WordsPlus(*#line 223.1 "parser.grm.sml"*)
)
end)
 in ( LrTable.NT 8, ( result, KW_MOVIE1left, WordsPlus1right), rest671)
end
|  ( 10, ( ( _, ( MlyValue.Number Number1, _, Number1right)) :: ( _, ( _, KW_AGE1left, _)) :: rest671)) => let val  result = MlyValue.Age (fn _ => let val  (Number as Number1) = Number1 ()
 in ((*#line 61.21 "parser.grm"*)Number(*#line 229.1 "parser.grm.sml"*)
)
end)
 in ( LrTable.NT 9, ( result, KW_AGE1left, Number1right), rest671)
end
| _ => raise (mlyAction i392)
end
val void = MlyValue.VOID
val extract = fn a => (fn MlyValue.Data x => x
| _ => let exception ParseInternal
	in raise ParseInternal end) a ()
end
end
structure Tokens : Actor_TOKENS =
struct
type svalue = ParserData.svalue
type ('a,'b) token = ('a,'b) Token.token
fun KW_NAME (p1,p2) = Token.TOKEN (ParserData.LrTable.T 0,(ParserData.MlyValue.VOID,p1,p2))
fun KW_MOVIE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 1,(ParserData.MlyValue.VOID,p1,p2))
fun KW_AGE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 2,(ParserData.MlyValue.VOID,p1,p2))
fun Name (i,p1,p2) = Token.TOKEN (ParserData.LrTable.T 3,(ParserData.MlyValue.Name (fn () => i),p1,p2))
fun Number (i,p1,p2) = Token.TOKEN (ParserData.LrTable.T 4,(ParserData.MlyValue.Number (fn () => i),p1,p2))
fun EOF (p1,p2) = Token.TOKEN (ParserData.LrTable.T 5,(ParserData.MlyValue.VOID,p1,p2))
end
end

