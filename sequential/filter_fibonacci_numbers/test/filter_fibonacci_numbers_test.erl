-module(filter_fibonacci_numbers_test).

-include_lib("eunit/include/eunit.hrl").

is_fib_test() ->
  ?assert(filter_fibonacci_numbers:is_fib(1)),
  ?assert(filter_fibonacci_numbers:is_fib(2)),
  ?assert(filter_fibonacci_numbers:is_fib(3)),
  ?assertNot(filter_fibonacci_numbers:is_fib(4)),
  ?assert(filter_fibonacci_numbers:is_fib(5)).

filter_fibonacci_numbers_test() ->
  List = [1, 2, 3, 4, 5, 7, 8, 9, 10],
  ?assertEqual([1, 2, 3, 5, 8], filter_fibonacci_numbers:filter(List)).
