extends Area2D

signal player_detected(player)
signal player_lost(player)

var player = null

func player_detected():
    return player != null
    
func _on_body_entered(body: Player):
    player = body
    emit_signal("player_detected", body)
    
func _on_body_exited(body: Player):
    player = null
    emit_signal("player_lost", body)
