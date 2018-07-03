-module(self_study_doctor_monitor).
-export([loop/0]).

loop() ->
	process_flag(trap_exit, true),
	receive
		new ->
			io:format("Creating doctor monitor and monitoring doctor.~n"),
			register(doctor, spawn_link(fun self_study_doctor_2:loop/0)),
			doctor ! {monitor, self()},
			doctor ! new,
			loop();

		die ->
			exit(monitor);

		{'EXIT', From, Reason} ->
			io:format("The doctor ~p died with reason ~p.", [From, Reason]),
			io:format("Restarting. ~n"),
			self() ! new,
			loop()
		end.

% c(roulette).
% c(self_study_doctor_2).
% c(self_study_doctor_monitor).
% Monitor = spawn(fun self_study_doctor_monitor:loop/0).
% Monitor ! new.