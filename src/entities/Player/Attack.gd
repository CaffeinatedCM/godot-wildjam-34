extends State

export var FRICTION = 500.0
export var ACCELRATION = 500.0
export var MAX_SPEED = 100.0

onready var player = get_parent().get_parent()
onready var animationTree = player.get_node("AnimationTree")
onready var gunAnimationTree = player.get_node("GunFlashAnimationTree")
onready var animationState = animationTree.get("parameters/playback")
onready var gunAnimationState = gunAnimationTree.get("parameters/playback")

var velocity = Vector2.ZERO

func exit():
    velocity = Vector2.ZERO

func update(delta):
    gunAnimationState.travel("Idle")
    var input_vector = Vector2.ZERO
    
    input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
    input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
    input_vector = input_vector.normalized()
    
    if input_vector != Vector2.ZERO:
        animationTree.set("parameters/AttackMove/blend_position", input_vector)
        animationTree.set("parameters/AttackIdle/blend_position", input_vector)
        gunAnimationTree.set("parameters/GunFlash/blend_position", input_vector)
        animationState.travel("AttackMove")
        velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELRATION * delta)
    else:
        animationState.travel("AttackIdle")
        velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
    
    player.move_and_slide(velocity)
    
    if Input.is_action_just_pressed("attack"):
        gunAnimationState.travel("GunFlash")

    if Input.is_action_just_pressed("draw_or_holster"):
            emit_signal("finished", "move")
