extends State

export var FRICTION = 500.0
export var ACCELRATION = 500.0
export var MAX_SPEED = 100.0

onready var carrot: KinematicBody2D = null
onready var playerDetector = null
onready var wanderController = null

var velocity = Vector2.ZERO

func enter():
    print_debug("Entering Wander State...")
    carrot = get_node("../..")
    playerDetector = get_node("../../PlayerDetector")
    wanderController = get_node("../WanderController")
    
    playerDetector.connect("player_detected", self, "_on_player_detected")
    
func update(delta: float):
    if wanderController.get_time_left() == 0:
        randomize_state()
        
    calc_movement_direction(wanderController.target_position, delta)
    velocity = carrot.move_and_slide(velocity)

func _on_player_detected(player: Player):
    emit_signal("finished", "pursue")

func randomize_state():
    print_debug("Randomizing Wander State...")
    # Check if we want to idle instead of move, and switch to an idle state if so
    if randi() % 2:
        emit_signal("finished", "idle")
    
    # Otherwise, start random timer on wander controller to update wander direction
    wanderController.start_wander_timer(rand_range(0, 3))

func calc_movement_direction(position: Vector2, delta: float):
    var direction = carrot.global_position.direction_to(position).normalized()
    velocity = velocity.move_toward(direction * MAX_SPEED, ACCELRATION * delta)
    
    if carrot.global_position.distance_to(wanderController.target_position) <= ACCELRATION:
        randomize_state()
