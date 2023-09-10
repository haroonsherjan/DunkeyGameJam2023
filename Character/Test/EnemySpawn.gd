extends Marker2D

const enemy_resource = preload("res://Character/Test/Enemy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(enemy_resource.instantiate())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
