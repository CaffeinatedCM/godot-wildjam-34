extends State

func _on_animation_finished(anim_name):
	if anim_name == "Growing":
		emit_signal("finished", "move")
