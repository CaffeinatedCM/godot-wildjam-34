extends Area2D

signal player_detected(player)
signal player_lost(player)

var player = null

func player_detected():
    return player != null
    
func _on_body_entered(body: Player):
    player = body
    print_debug("Player Detected...")
    emit_signal("player_detected", body)
    
func _on_body_exited(body: Player):
    player = null
    print_debug("Player Lost...")
    emit_signal("player_lost", body)
