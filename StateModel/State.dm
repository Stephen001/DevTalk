StateModel/StateTransition
	var/StateModel/State/state
	var/StateModel/Transition/transition

	New(var/StateModel/Transition/transition, var/StateModel/State/state)
		src.state 		= state
		src.transition 	= transition

StateModel/State
	var/name

	New(var/name as text)
		src.name = name

StateModel/Transition
	apply(var/StateModel/TransitionData/D)
		return 0

StateModel/TransitionData

StateModel/StateMachine
	var/list/allowed_transitions = new()
	var/StateModel/State/current_state

	New(var/StateModel/State/initial_state)
		src.current_state = initial_state

	add_new_transition(var/StateModel/State/from, var/StateModel/State/tostate, var/StateModel/Transition/how)
		var/StateModel/StateTransition/ST = new(how, tostate)
		var/list/L = allowed_transitions[from]
		if (L == null)
			L = new()
			allowed_transitions[from] = L
		L.Add(ST)

	apply_data(var/StateModel/TransitionData/D)
		var/list/L = allowed_transitions[current_state]
		if (L != null)
			for (var/StateModel/StateTransition/ST in L)
				if (ST.transition.apply(D))
					current_state = ST.state
					return

	current_state()
		return current_state

	end_state()
		return allowed_transitions[current_state] == null

	set_state(var/StateModel/State/initial_state)
		src.current_state = initial_state
