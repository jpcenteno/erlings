-module(shopping_cart).

-behaviour(gen_server).

-export([start_link/0, put_item/2, finish/1, cost_so_far/1]).
-export([init/1, handle_call/3, handle_cast/2]).

start_link() ->
    gen_server:start_link(?MODULE, [], []).

put_item(Pid, Item) ->
    gen_server:call(Pid, {put_item, Item}).

cost_so_far(Pid) ->
    gen_server:call(Pid, {cost_so_far}).

finish(Pid) ->
    gen_server:call(Pid, {finish}).

%% -----------------------------------------------------------------------------
%% Private
%% -----------------------------------------------------------------------------

init(Items) ->
    {ok, Items}.

handle_call({put_item, Item}, _From, Items) ->
    NewItems = [Item | Items],
    {reply, NewItems, NewItems};
handle_call({cost_so_far}, _From, Items) ->
    {reply, total_cost(Items), Items};
handle_call(finish, _From, Items) ->
    {stop, normal, ok, total_cost(Items)}.


total_cost(Items) ->
    lists:sum([Cost || {_Name, Cost} <- Items]).

%%% Generic handle_cast. Unused here.
handle_cast(_Request, State) ->
  {noreply, State}.
