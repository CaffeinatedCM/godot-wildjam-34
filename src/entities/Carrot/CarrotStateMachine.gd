extends StateMachine

func _ready():
    states_map = {
        "grow": $Grow,
        "wander": $Wander,
        "idle": $Idle,
        "pursue": $Pursue
    }

