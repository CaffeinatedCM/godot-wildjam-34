extends KinematicBody2D

export var Health = 3

func _on_Hurtbox_area_entered(area):
    Health -= area.DAMAGE
    print("carrot health" + String(Health))
