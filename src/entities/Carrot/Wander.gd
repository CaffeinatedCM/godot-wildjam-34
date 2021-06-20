extends State

export var FRICTION = 500.0
export var ACCELRATION = 500.0
export var MAX_SPEED = 100.0

onready var carrot: KinematicBody2D = null
onready var playerDetector = null
onready var wanderController = null

var velocity = Vector2.ZERO

func enter():
    print("Hello Wanderer")
    carrot = get_node("../..")
    playerDetector = get_node("../../PlayerDetector")
    wanderController = get_node("./WanderController")
    playerDetector.connect("player_detected", self, "_on_player_detected")
    
func update(delta: float):
    var direction = carrot.global_position.direction_to(wanderController.target_position).normalized()
    velocity = velocity.move_toward(direction * MAX_SPEED, ACCELRATION * delta)
    velocity = carrot.move_and_slide(velocity)

func _on_player_detected(player: Player):
    emit_signal("finished", "pursue")
