extends CharacterBody2D

var is_following = false
var is_close_enough = false
var move_speed: float = 100
var player

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_following and not is_close_enough:
		var direction = player.global_transform.origin - global_transform.origin
		direction = direction.normalized()
		translate(direction * move_speed * delta)

func set_following(player: Node2D):
	is_following = true
	self.player = player
