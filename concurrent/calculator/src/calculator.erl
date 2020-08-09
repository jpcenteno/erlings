-module(calculator).
-export([start_calculator/0,
         calculator_server/0,
         turn_off/1,
         add/3,
         subtract/3,
         multiply/3,
         divide/3]).

%% -------------------------------------------------------------------------
%% Calculator API
%% -------------------------------------------------------------------------

start_calculator() ->
  spawn(calculator, calculator_server, []).

turn_off(Pid) ->
  Pid ! off.

add(Cal, X, Y) ->
  compute(Cal, add, X, Y).

subtract(Cal, X, Y) ->
  compute(Cal, subtract, X, Y).

multiply(Cal, X, Y) ->
  compute(Cal, multiply, X, Y).

divide(Cal, X, Y) ->
  compute(Cal, divide, X, Y).

%% -------------------------------------------------------------------------
%% Calculator internals
%% -------------------------------------------------------------------------

calculator_server() ->
  receive

    {Pid, {Op, X, Y}} ->
      Pid ! {self(), compute(Op, X, Y)};

    off ->
      io:format("Bye from ~p~n", [self()]);

    UnknownMessage ->
      io:format("I don't understand message ~w~n", [UnknownMessage]),
      calculator_server()
  end.

compute(Cal, Op, X, Y) ->
  Cal ! {self(), {Op, X, Y}},
  receive
    {Cal, Result} -> Result
  end.

compute(add, X, Y)      -> X + Y;
compute(subtract, X, Y) -> X - Y;
compute(multiply, X, Y) -> X * Y;
compute(divide, X, Y)   -> X / Y.
