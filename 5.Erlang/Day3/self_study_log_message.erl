-module(self_study_log_message).
-behaviour(gen_server).
-define(SERVER, ?MODULE).

-export([start_link/0, stop/0, echo/1]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

start_link() ->
	gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).

stop() ->
	gen_server:cast(?SERVER, stop).

echo(Message) ->
	gen_server:call(?SERVER, {echo, Message}).

init([]) ->
	{ok, []}.

handle_call({echo, Message}, _From, State) ->
	io:format("Received call From: ~p with message: ~p~n", [_From, Message]),
	FileStatus = file:open("log.txt", [append]),
	case FileStatus of
		{ok, File} -> 
			file:write(File, Message);
		{error, Reason} -> io:format("Error opening file: ~p~n", [Reason])
	end,
	{reply, Message, State}.

handle_cast(stop, State) ->
	{stop, normal, State}.

handle_info(Info, State) ->
	error_logger:info_msg("~p~n", [Info]),
	{noreply, State}.

terminate(_Reason, _State) ->
	error_logger:info_msg("terminating~n"),
	ok.

code_change(_OldVsn, State, _Extra) ->
	{ok, State}.