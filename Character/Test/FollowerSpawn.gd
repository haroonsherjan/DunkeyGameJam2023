extends Marker2D
var follower = preload("res://Character/Follower.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(follower.instantiate())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
