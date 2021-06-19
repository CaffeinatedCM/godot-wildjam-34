extends State

export var FRICTION = 1000.0
export var ACCELRATION = 100.0
export var MAX_SPEED = 100.0

onready var player = get_parent().get_parent()
onready var animationTree = player.get_node("AnimationTree")
onready var animationState = animationTree.get("parameters/playback")

var velocity = Vector2.ZERO

func update(delta):
	var input_vector = Vector2.ZERO
	
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		animationTree.set("parameters/Move/blend_position", input_vector)
		animationState.travel("Move")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELRATION * delta)
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	player.move_and_slide(velocity)
