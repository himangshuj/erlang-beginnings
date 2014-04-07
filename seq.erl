%% This file has sample code to test out constructs of sequential programming
-module('seq').
-export([factorial/2,sum/1,sum/2,create/1,create_reverse/1]).

factorial(N,K) when N > 0 ->
    factorial(N - 1,N*K);
factorial(0,K) -> K.

%% Adds using accumulator it is private
addition(ACC,N) when N > 0 ->
    addition(ACC+N,N-1);
addition(ACC,0) ->
    ACC.
sum(N) ->
    addition(0,N).
%% This does not use accumulator

sum(N,M) when N < M ->
    N + sum(N+1,M);
sum(N,N) ->
    N.

%% create inner list
create_inner(INDEX,INDEX)  ->
    [INDEX];
create_inner(INDEX,MAX) ->
    [INDEX|create_inner(INDEX+1,MAX)].

create(N) when N > 0 ->
    create_inner(1,N).

%% create list reverse

create_reverse(N) when N > 1 ->
    [N|create_reverse(N-1)];
create_reverse(1) -> [1].







