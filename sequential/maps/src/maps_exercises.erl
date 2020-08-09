-module(maps_exercises).
-export([sum_of_values/1,return_values/1,sort_by_keys/1,min_value/1,merge/2, map/2, to_map/1, records_to_maps/1, maps_to_records/1, proplist_to_map/1]).

-record(person, {name, age}).

sum_of_values(Map) ->
  Operation = fun (_, V, Acc) -> V + Acc end,
  maps:fold(Operation, 0, Map).

min_value(Map)->
  Values = maps:values(Map),
  lists:min(Values).

sort_by_keys(Map)->
  UnsortedKVList = maps:to_list(Map),
  SortedKVList = lists:sort(fun compare_kv_by_key/2, UnsortedKVList),
  maps:from_list(SortedKVList).

compare_kv_by_key({K1, _V1}, {K2, _V2}) ->
  K1 =< K2.

% I assume that using maps:values/1 is not allowed here.
return_values(Map)->
  KVTuplesList = maps:to_list(Map),
  lists:map(fun ({_, V}) -> V end, KVTuplesList).

merge(Map1, Map2) ->
  KVL = maps:to_list(Map2),
  merge_kv_list_into_map(KVL, Map1).

merge_kv_list_into_map([], Map) ->
  Map;
merge_kv_list_into_map([{K, V} | T], Map) ->
  NewMap = maps:put(K, V, Map),
  merge_kv_list_into_map(T, NewMap).

map(Function, Map) ->
  FunctionForTuples = fun (_, V) -> Function(V) end,
  maps:map(FunctionForTuples, Map).

to_map(List) ->
  to_map(1, List, #{}).

to_map(K, [], Acc) ->
  Acc;
to_map(K, [V | T], Acc) ->
  to_map(K + 1, T, maps:put(K, V, Acc)).

records_to_maps(Records) ->
  lists:map(fun person_to_map/1, Records).

person_to_map(#person{age=Age, name=Name}) ->
  #{age => Age, name => Name}.

maps_to_records(Maps) ->
  maps_to_records(Maps, []).

maps_to_records([], Acc) ->
  Acc;
maps_to_records([Map | T], Acc) ->
  NewAcc = [map_to_person(Map) | Acc],
  maps_to_records(T, NewAcc).

map_to_person(#{age := Age, name := Name}) ->
  #person{age=Age, name=Name}.

proplist_to_map(Proplist) ->
  proplist_to_map(Proplist, #{}).

proplist_to_map([], Acc) ->
  Acc;
proplist_to_map([{K, V} | T], Acc) ->
  NewAcc = maps:put(K, V, Acc),
  proplist_to_map(T, NewAcc).
