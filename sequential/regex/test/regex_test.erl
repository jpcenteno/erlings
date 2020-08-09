-module(regex_test).
-include_lib("eunit/include/eunit.hrl").

empty_regex_matches_nothing_test() ->
    ?assertNot(regex:match("foo", "")).

matches_characters_test() ->
    ?assert(regex:match("a", "a")).

char_literals_dont_match_other_characters_test() ->
    ?assertNot(regex:match("b", "a")).

matches_first_number_but_mismatches_the_second_test() ->
    ?assertNot(regex:match("42", "49")).

matches_numbers_test() ->
    ?assert(regex:match("49", "49")).

matches_question_mark_test() ->
    ?assert(regex:match("Hi", "h?")).

matches_multiple_chars_test() ->
    ?assert(regex:match("aaaaaaaaa", "a*")).

matches_empty_string_test() ->
    ?assert(regex:match(" ", "a*")).

matches_any_character_test() ->
    ?assert(regex:match("asdf as 42", ".")).
