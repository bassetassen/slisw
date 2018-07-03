-module(self_study_doctor).
-export([loop/0]).

% Make the doctor restart itself if it should fail
% Can fail it from repl with: exit(Doctor, doctor).

loop() ->
	process_flag(trap_exit, true),
	receive
		new ->
			io:format("Creating and monitoring process.~n"),
			register(revolver, spawn_link(fun roulette:loop/0)),
			loop();
		{'EXIT', From, Reason} ->
			io:format("From ~p with reason ~p.", [From, Reason]),
			case Reason of				
				doctor ->
					io:format("Doctor died~n"),
					exit(whereis(revolver), revolver),
					Doctor = spawn(fun self_study_doctor:loop/0),
					Doctor ! new;
				_ ->
					io:format("The shooter ~p died with reason ~p.", [From, Reason]),
					io:format("Restarting. ~n"),
					self() ! new,
					loop()
				end
		end.