-module(hello_pattern).

-export([hello/1]).

hello({morning, _}) -> morning;
hello({night, _}) -> night;
hello({evening, Name}) -> {good, evening, Name};
hello({math_class, Number, _}) when Number < 0-> none;
hello({math_class, _, Name}) -> {math_class, Name}.
