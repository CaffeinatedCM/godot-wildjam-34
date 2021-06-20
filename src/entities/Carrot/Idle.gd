extends State

export var FRICTION = 100.0

onready var carrot: KinematicBody2D = get_node("../..")
onready var playerDetector = get_node("../../PlayerDetector")
onready var wanderController = get_node("../WanderController")

var velocity = Vector2.ZERO

func enter():
    print("Entering Idle State")
    playerDetector.connect("player_detected", self, "_on_player_detected")
    wanderController.start_wander_timer(rand_range(0, 3)) 
    
func update(delta: float):
    if wanderController.get_time_left() == 0:
        randomize_state()
    else:
        velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
        velocity = carrot.move_and_slide(velocity)

func randomize_state():
    print("Randomizing idle state")
    if randi() % 2:
        emit_signal("finished", "wander")
    else:
        wanderController.start_wander_timer(rand_range(0, 3))
    
func _on_player_detected(player: Player):
    emit_signal("finished", "pursue")
