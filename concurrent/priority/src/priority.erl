-module(priority).

-export([start/0,
         get_messages/1,
         priority_loop/1]).

start() ->
  spawn(?MODULE, priority_loop, [[]]).


get_messages(Pid) ->
  Pid ! {get_messages, self()},
  receive
    {Pid, List} ->
      %% I decided to do the reversing on the caller process to prevent the
      %% `priority_loop` process from blocking.
      lists:reverse(List)
  end.

priority_loop(List) ->
  receive
    {vip, _} = Msg -> priority_loop([Msg | List])
    after 0 ->
      receive
        {normal, _} = Msg -> priority_loop([Msg | List]);
        {get_messages, Pid} -> Pid ! {self(), List}
        after 0 -> priority_loop(List)
      end
    end.
