Showcode/TokenRule/LineComment
	var/StateModel/State/initial
	var/StateModel/State/failed
	var/StateModel/State/complete
	var/StateModel/state

	New()
		initial 						= new("Initial")
		var/StateModel/State/escaped 	= new("Escaped")
		failed  						= new("Failed")
		var/StateModel/State/one_slash  = new("One_Slash")
		var/StateModel/State/running  	= new("Running")
		complete   						= new("Complete")
		state = new(initial)
		var/StateModel/Transition/Other/O 		= new()
		var/StateModel/Transition/Character/C 	= new(92)
		state.add_new_transition(initial, escaped, C)
		O.add_transition(C)
		C = new(47)
		O.add_transition(C)
		state.add_new_transition(initial, one_slash, C)
		state.add_new_transition(initial, failed, O)
		O = new()
		O.add_transition(C)
		state.add_new_transition(one_slash, running, C)
		state.add_new_transition(one_slash, failed, O)
		C = new(10)
		state.add_new_transition(running, complete, C)

	matches(var/char as num)
		var/StateModel/TransitionData/Character/C = new(char)
		state.apply_data(C)
		return state.current_state != failed

	finished()
		return state.current_state == complete

	reset()
		state.set_state(initial)