-module(self_study).
-export([word_count/1]).
-export([count_to_ten/0]).
-export([match/1]).

% Write a function that uses recursion to return the number of words in a string
word_count([]) -> 0;
word_count(Sentence)-> count(Sentence, 1).

count([], Count) -> Count;
count([32|Tail], Count) -> count(Tail, Count + 1);
count([_|Tail], Count) -> count(Tail, Count).

% Write a function that uses recursion to count to ten
count_to_ten() -> count_to_ten(1).
count_to_ten(10) -> io:fwrite("10~n");
count_to_ten(N) -> 
	io:format("~w~n", [N]),
	count_to_ten(N+1).


% Write a function that uses matching to selectively print "success" or "error: message"
% given the input of the form {error,Message} or success
match(success) -> "success";
match({error, Message}) -> "error: " ++ Message.