-module(self_study).
-export([keywordfinder/2]).
-export([shopping_list/1]).
-export([tic_tac_toe/1]).

% Consider a list og keyword-value tuples, such as [{erlang, "a functional language"},
% {ruby, "a OO language"}]. Write a function that accepts the list and a keyword and
% returns the associated value for the keyword.

keywordfinder(Keywords, Keyword) -> 
	printTupleList(lists:filter(fun({X, _}) -> X == Keyword end, Keywords)).

printTupleList([]) -> "No match";
printTupleList([{_, Value}]) -> Value.

% Consider a shopping list that looks like [{item quantity price}, ...]. Write a
% list comprehension that builds a list of items of the form [{item total_price}, ...],
% where total_price is quantity times price

shopping_list(X) -> [{Item, Price * Quantity} || {Item, Quantity, Price} <- X].

% Write a program that reads a tic-tac-toe board represented as a list or a tuple of
% size nine. Return the winner (x or o) if a winner has been determined. cat if there
% is no more possible moves, or no_winner if no player has won yet.

tic_tac_toe([Y,Y,Y,_,_,_,_,_,_]) -> Y;
tic_tac_toe([_,_,_,Y,Y,Y,_,_,_]) -> Y;
tic_tac_toe([_,_,_,_,_,_,Y,Y,Y]) -> Y;
tic_tac_toe([Y,_,_,Y,_,_,Y,_,_]) -> Y;
tic_tac_toe([_,Y,_,_,Y,_,_,Y,_]) -> Y;
tic_tac_toe([_,_,Y,_,_,Y,_,_,Y]) -> Y;
tic_tac_toe([Y,_,_,_,Y,_,_,_,Y]) -> Y;
tic_tac_toe([_,_,Y,_,Y,_,Y,_,_]) -> Y;
tic_tac_toe(Board) -> 
	MoreMoves = lists:any(fun(Y) -> Y == "" end, Board),
	case MoreMoves of
		true -> no_winner;
		_ -> cat
	end.

