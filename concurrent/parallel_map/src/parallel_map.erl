-module(parallel_map).
-export([pmap/2, worker/4]).

pmap(Fun, List) ->
  pmap(1, Fun, List).

pmap(I, _Fun, []) ->
  collect(I - 1, []);
pmap(I, Fun, [H | T]) ->
  spawn(parallel_map, worker, [self(), I, Fun, H]),
  pmap(I + 1, Fun, T).

worker(From, I, Fun, H) ->
  From ! {I, Fun(H)}.

collect(0, Acc) ->
  OrdFun = fun ({Ia, _}, {Ib, _}) -> Ia =< Ib end,
  SortedResults = lists:sort(OrdFun, Acc),
  lists:map(fun ({_, V}) -> V end, SortedResults);
collect(I, Acc) ->
  receive
    {I, Result} -> collect(I - 1, [{I, Result} | Acc])
  end.
