-module(self_study_doctor_2).
-export([loop/0]).

loop() ->
	process_flag(trap_exit, true),
	receive
		new ->
			io:format("Creating and monitoring process.~n"),
			register(revolver, spawn_link(fun roulette:loop/0)),
			loop();

		{ monitor, Process } ->
			io:format("Doctor now monitoring monitor~n"),
			link(Process),
			loop();

		die ->
			exit(doctor);

		{'EXIT', From, Reason} ->
			case Reason of
				monitor ->
					io:format("Monitor is down.."),
					exit(whereis(revolver), revolver),
					Monitor = spawn(fun self_study_doctor_monitor:loop/0),
					Monitor ! new;
				{roulette, _, _ , _} ->
					io:format("The shooter ~p died with reason ~p.", [From, Reason]),
					io:format("Restarting. ~n"),
					self() ! new,
					loop();
				_ ->
					io:format("In exit in doctor~n"),
					loop()
			end
		end.