extends StateMachine

func _ready():
	states_map = {
		"grow": $Grow,
		"move": $Move
	}

