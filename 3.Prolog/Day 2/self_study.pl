%-- Reverse list

rev([A,B], [B,A]).
rev([Head|Tail], ReversedList) :-
	rev(Tail, RevTail),
	append(RevTail, [Head], ReversedList).


%----------------------------------------------------

%-- Find smallest element in list
findMin([Head|[]], Head).
findMin([Head|Tail], TailMin) :- findMin(Tail, TailMin), TailMin =< Head.
findMin([Head|Tail], Head) :- findMin(Tail, TailMin), TailMin > Head.

%-- Sorting a list