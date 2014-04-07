-module('evaluator').
-author('himangshuj').
-export([eval/1,parse/1]).

%% Parsing logic, there are three parts to any expression
%% operator operand1 and operand2
%% Objective is to split the expression into operand1 and operand2 by identifying the expression
%% since all expressions are encapsulated inside (), we assume the entire expression to be operand2
%% now we shift the head from operand2 to operand1 and reduce the operand2, this is repeated till 
%% we have exactly one left braces more than right braces, since we start with a left braces and we encounter
%% a operator +,-,*,/ 
parser(LeftBraces,Operand1,[HeadOperand2|TailOperand2]) ->
    if 
	HeadOperand2 == 126 -> %%handling urinary can only happen at start
	    {minus, 0, parser(0,"",TailOperand2)};
	HeadOperand2 == 40 -> 
	    parser(LeftBraces+1,Operand1++[HeadOperand2],TailOperand2);
	HeadOperand2 == 41 ->
	    parser(LeftBraces-1,Operand1++[HeadOperand2],TailOperand2);
	LeftBraces == 1 ->
	    if 
		HeadOperand2 == 42 ->
		    {multiply,parser(0,[],tl(Operand1)),parser(0,[],lists:sublist(TailOperand2,length(TailOperand2) -1))};
		HeadOperand2 == 43 ->
		    {plus,parser(0,[],tl(Operand1)),parser(0,[],lists:sublist(TailOperand2,length(TailOperand2) -1))};		    
		HeadOperand2 == 45 ->
		    {minus,parser(0,[],tl(Operand1)),parser(0,[],lists:sublist(TailOperand2,length(TailOperand2) -1))};
		HeadOperand2 == 47 ->
		    {divide,parser(0,[],tl(Operand1)),parser(0,[],lists:sublist(TailOperand2,length(TailOperand2) -1))};
		true ->
		    parser(LeftBraces,Operand1++[HeadOperand2],TailOperand2)
	    end;
	LeftBraces == 0 ->
	    {num,element(1,string:to_integer ([HeadOperand2|TailOperand2]))};
	true ->
	    parser(LeftBraces,Operand1++[HeadOperand2],TailOperand2)
    end.

%% external definition for parser
parse(Exp) ->
    parser(0,"",Exp).

evaluate({num,E}) ->
    E;
evaluate({minus,Exp1,Exp2}) ->
    evaluate(Exp1) - evaluate(Exp2);
evaluate({multiply,Exp1,Exp2}) ->
    evaluate(Exp1)*evaluate(Exp2);
evaluate({divide,Exp1,Exp2}) ->
    evaluate(Exp1)/evaluate(Exp2);
evaluate({plus,Exp1,Exp2}) ->
    evaluate(Exp1)+evaluate(Exp2).

eval(Expr) ->
    evaluate(parse(Expr)).


