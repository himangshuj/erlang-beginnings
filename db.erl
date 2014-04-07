-module('db').
-export([new/0,destroy/0,write/3,read/2,match/2]).
new() ->
    [].
destroy() ->
    ok.
write(Key,Element,Db) ->
    [{Key,Element}|Db].
read (Key,[Head|_]) when element(1,Head) == Key ->
    {ok,element(2,Head)};
read (Key,[_|Tail]) ->
    read(Key,Tail).
match (Val,[Head|Tail]) when length(Tail)>0 ->
    if(element(2,Head)==Val) ->
	    [element(1,Head)|match(Val,Tail)];
      true ->
	    match(Val,Tail)
    end;
match (Val,[Last]) ->
    if (element(2,Last)==Val) -> 
	    [element(1,Last)];
       true -> []
    end.
