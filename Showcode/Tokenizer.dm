Showcode/TokenRule
	proc
		matches(var/T as num)

		finished()

		reset()

StateModel/Transition/Character
	var/char

	New(var/char as num)
		src.char = char

	apply(var/StateModel/TransitionData/Character/C)
		return C.char == char

StateModel/Transition/Other
	var/list/transitions = new()

	proc/add_transition(var/StateModel/Transition/transition)
		transitions.Add(transition)

	apply(var/StateModel/TransitionData/Character/C)
		for (var/StateModel/Transition/transition in transitions)
			if (transition.apply(C))
				return 0
		return 1

StateModel/TransitionData/Character
	var/char

	New(var/char as num)
		src.char = char