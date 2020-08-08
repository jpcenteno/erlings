-module(insert_element_at).

-export([insert/3]).

insert(List, Pos, Element) ->
  Fun = fun (OldValue) -> update_velue(OldValue, Element) end,
  update_nth(Pos, List, Fun).

update_nth(1, [H | T], Fun) ->
  [Fun(H) | T];
update_nth(Nth, [H | T], Fun) ->
  [H | update_nth(Nth - 1, T, Fun)].

update_velue(#{current := OldValue}, NewValue) ->
  #{current => NewValue, old => OldValue};
update_velue(OldValue, NewValue) ->
  #{current => NewValue, old => OldValue}.
