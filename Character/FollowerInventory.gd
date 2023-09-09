extends Node2D

var follower_scene = ProjectSettings.get_setting("follower_resource")
var followers = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

###

func _on_close_enough_body_entered(body):
	body.is_close_enough = true

func _on_close_enough_body_exited(body):
	body.is_close_enough = false

func _on_discover_followers_body_entered(body):
	body.set_following(self)
	
