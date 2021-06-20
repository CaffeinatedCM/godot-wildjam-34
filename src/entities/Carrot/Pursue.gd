extends State

export var FRICTION = 500.0
export var ACCELRATION = 500.0
export var MAX_SPEED = 100.0

# When we get to this state we should have found a player, and the player lost signal from the player detector has not fired yet
onready var playerDetector = get_node("../../PlayerDetector")

var player: Player = null
var carrot: KinematicBody2D = null
var velocity = Vector2.ZERO

func enter():
    playerDetector.connect("player_lost", self, "_on_player_lost")
    player = playerDetector.player
    carrot = get_node("../..")
    
func update(delta):
    var direction = carrot.global_position.direction_to(player.global_position).normalized()
    velocity = velocity.move_toward(direction * MAX_SPEED, ACCELRATION * delta)
    carrot.move_and_slide(velocity)
    
func _on_player_lost(player: Player):
    emit_signal("finished", "wander")
