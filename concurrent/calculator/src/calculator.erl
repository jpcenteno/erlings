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
  Cal ! {self(), {add, X, Y}},
  receive
    {Cal, Result} -> Result
  end.

subtract(Cal, X, Y) ->
  Cal ! {self(), {subtract, X, Y}},
  receive
    {Cal, Result} -> Result
  end.

multiply(Cal, X, Y) ->
  Cal ! {self(), {multiply, X, Y}},
  receive
    {Cal, Result} -> Result
  end.

divide(Cal, X, Y) ->
  Cal ! {self(), {divide, X, Y}},
  receive
    {Cal, Result} -> Result
  end.

%% -------------------------------------------------------------------------
%% Calculator internals
%% -------------------------------------------------------------------------

calculator_server() ->
  receive

    {Pid, {add, X, Y}} ->
      Pid ! {self(), X + Y};

    {Pid, {subtract, X, Y}} ->
      Pid ! {self(), X - Y};

    {Pid, {multiply, X, Y}} ->
      Pid ! {self(), X * Y};

    {Pid, {divide, X, Y}} ->
      Pid ! {self(), X / Y};

    off ->
      io:format("Bye from ~p~n", [self()]);

    UnknownMessage ->
      io:format("I don't understand message ~w~n", [UnknownMessage]),
      calculator_server()
  end.
