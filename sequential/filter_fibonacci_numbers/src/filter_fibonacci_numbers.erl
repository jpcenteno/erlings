-module(filter_fibonacci_numbers).

-export([filter/1, is_fib/1]).

filter(List) ->
  [X || X <- List, is_fib(X)].

is_fib(1) -> true;
is_fib(X) when X >= 2 ->
  is_fib(X, 2, 1).

is_fib(X, Fi, _Fj) when X < Fi->
  false;
is_fib(X, X, _Fj) ->
  true;
is_fib(X, Fi, Fj) ->
  is_fib(X, Fi + Fj, Fi).
