extends KinematicBody2D

class_name Player

export var Health = 10

func _ready():
    $AnimationTree.active = true
    $GunFlashAnimationTree.active = true


func _on_Hurtbox_area_entered(area):
    Health -= area.DAMAGE
    print(Health)
    pass # Replace with function body.
