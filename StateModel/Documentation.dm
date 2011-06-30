/**
 * The most basic element in any state model, the state. States are nodes
 * on a graph that a state machine may be in. For the purposes of this
 * library and version, a state is just a datum with a name.
 */
StateModel/State
	/**
	 * Constructs a new state, with the given name.
	 *
	 * @param name The printable name of this state.
	 */
	New(var/name as text)

/**
 * A transition represents a movement between two states. Typically a transition
 * has a certain number of conditions that must be fulfilled in order to be
 * valid. Extend this datum to implement your logic for transitions.
 *
 * Although not required, it is expected that transitions will hold no
 * internal state of their own.
 */
StateModel/Transition
	/**
	 * Called when the state machine attempts to see if the transition is valid
	 * for a given input. By default, this proc returns 0.
	 *
	 * @param D The data input from the external world, which this transition may
	 *			use to decided if this transition is valid.
	 * @return  1 if this transition is valid, 0 otherwise.
	 */
	proc/apply(var/StateModel/TransitionData/D)

/**
 * A datum to hold information about the external world. This is a free-form datum
 * that should be extended to include whatever data your transitions will require.
 */
StateModel/TransitionData

/**
 * The state machine, encompassing a potentially complex graph of states and potential
 * transitions between them.
 */
StateModel/StateMachine
	/**
	 * Constructs the state machine with an initial state.
	 *
	 * @param initial_state The starting point of this state machine.
	 */
	New(var/StateModel/State/initial_state)

	/**
	 * Adds a new potential transition between two states.
	 *
	 * @param from 		The state to potentially move from.
	 * @param tostate	The state to potentially move to.
	 * @param how		The transition logic required to move between the two states.
	 */
	proc/add_new_transition(var/StateModel/State/from, var/StateModel/State/tostate, var/StateModel/Transition/how)

	/**
	 * Applies the provided data to the state machine, potentially causing a change
	 * in current state.
	 *
	 * @param D The external wotld data to apply to this state machine.
	 */
	proc/apply_data(var/StateModel/TransitionData/D)

	/**
	 * Gets the current state this state machine is in.
	 *
	 * @return The current state this state machine is in.
	 */
	proc/current_state()

	/**
	 * Checks whether or not this state machine is in an end state.
	 *
	 * @return 1 if not further transitions could ever be performed, or 0 otherwise.
	 */
	proc/end_state()

	/**
	 * Forcibly set the current state to a given state.
	 *
	 * @param initial_state The state to force the state machine into.
	 */
	proc/set_state(var/StateModel/State/initial_state)

