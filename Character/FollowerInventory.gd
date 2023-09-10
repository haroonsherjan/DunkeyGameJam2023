extends Node2D

var follower_scene = ProjectSettings.get_setting("follower_resource")
var followers = []
var close_enough = []
var equipped: CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if equipped:
		self.equipped.global_position = $FollowerHolster.global_position

func _on_close_enough_body_entered(body):
	body.is_close_enough = true
	close_enough.append(body)

func _on_close_enough_body_exited(body):
	body.is_close_enough = false
	close_enough.erase(body)

func _on_discover_followers_body_entered(body):
	body.set_following(self)
	followers.append(body)

func equip_follower()->void:
	self.equipped = self.close_enough.front()
	$FollowerHolster.add_child(self.equipped)
