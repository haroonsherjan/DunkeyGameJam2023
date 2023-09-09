extends Marker2D
var player = load("res://Character/Avatar.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(player.instantiate())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
