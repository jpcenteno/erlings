-module(ring).
-compile(export_all).

%-export([ring/2, ring_node/1]).

%% N processes, M messages
ring(N, M) ->
  Nodes = create_ring(N),
  [FirstNode | NodesRingTail] = [Node || _ <- lists:seq(1, M), Node <- Nodes],
  FirstNode ! {1, NodesRingTail},
  io:format("[ring] waiting for receive~n"),
  receive
    #{msgs_sent := NumMessagesSent} ->
      #{msgs_sent => NumMessagesSent, procs_started => N}
  end.

%% -----------------------------------------------------------------------------
%% Ring node
%%
%% This should be in it's own module, but for the sake of this kata, I'm writing
%% everything into the same `.erl` file.
%% -----------------------------------------------------------------------------

create_ring(N) ->
  lists:map(fun (_) -> spawn(?MODULE, ring_node, [self(), N]) end,
            lists:seq(1, N)).

ring_node(Master, N) ->
  receive
    {I, []}             ->
      io:format("[node] message: ~B~n", [I]),
      Master ! #{msgs_sent => I, procs_started => N};
    {I, [Next | Nodes]} ->
      io:format("[node] message: ~B~n", [I]),
      Next   ! {I + 1, Nodes}
  end,
  ring_node(Master, N).
