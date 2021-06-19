extends Area2D

var player = null

func player_detected():
	return player != null
	
func _on_body_entered(body: Player):
	player = body
	print_debug("Player entered collector")
	
func _on_body_exited(body: Player):
	player = null
	print_debug("Player exited collector")
