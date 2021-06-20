extends Area2D

export var invincibility_durration = 1.0

onready var invincibilityTimer = $InvincibilityTimer

var invincible = false setget set_invincible

func set_invincible(value):
    invincible = value
    if invincible:
        set_deferred("monitoring", false)
    else:
        set_deferred("monitoring", true)
        
func start_invincibility():
    invincibilityTimer.start(invincibility_durration)
    set_invincible(true)

func _on_Hurtbox_area_entered(area):
    if invincible:
        return
    start_invincibility()

func _on_InvincibilityTimer_timeout():
    set_invincible(false)
