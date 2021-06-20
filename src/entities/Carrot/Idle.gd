extends State

export var FRICTION = 500.0

onready var carrot: KinematicBody2D = null
onready var playerDetector = null
onready var wanderController = null

var velocity = Vector2.ZERO

func enter():
    print_debug("Entering Idle State")
    carrot = get_node("../..")
    playerDetector = get_node("../../PlayerDetector")
    wanderController = get_node("../WanderController")
    
    playerDetector.connect("player_detected", self, "_on_player_detected")
    
func update(delta: float):
    if wanderController.get_time_left() == 0:
        randomize_state()
        
    velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
    velocity = carrot.move_and_slide(velocity)

func randomize_state():
    print_debug("Randomizing idle state")
    if randi() % 2:
        emit_signal("finished", "wander")
    
func _on_player_detected(player: Player):
    emit_signal("finished", "pursue")
