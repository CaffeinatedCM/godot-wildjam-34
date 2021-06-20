extends Control

export var playerRefPath: NodePath

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


var playerRef = null

# Called when the node enters the scene tree for the first time.
func _ready():
    playerRef = get_node(playerRefPath)

