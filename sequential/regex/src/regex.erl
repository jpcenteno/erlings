-module(regex).

-export([match/2]).

match(_String, "") ->
    false;
match(String, Regex) ->
    match_aux(string:lowercase(String), string:lowercase(Regex)).

match_aux(_String, "") ->
    true;

match_aux([Literal | StringTail], [Literal, $? | RegexTail]) ->
    io:format("You are here~n"),
    match_aux(StringTail, RegexTail);

match_aux(String, [_Literal, $? | RegexTail]) ->
    match_aux(String, RegexTail);

match_aux([Literal | StringTail], [Literal, $* | _RegexTail] = Regex) ->
    match_aux(StringTail, Regex);

match_aux(String, [Literal, $* | RegexTail]) ->
    match_aux(String, RegexTail);

match_aux([_Char | StringTail], [$. | RegexTail]) ->
    match_aux(StringTail, RegexTail);

match_aux([Char | StringTail], [Literal | RegexTail]) ->
    (Char =:= Literal) andalso match_aux(StringTail, RegexTail).
