extends CharacterBody2D

var is_close_enough = false
var move_speed: float = 100
var player
var state = "IDLE"
var states = {
	"IDLE": self.stay,
	"FOLLOWING": self.move,
	"EQUIPPED": self.stay
	}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	states.get(state).call(delta)

func stay(delta):
	pass

func move(delta):
	if not is_close_enough:
		var direction = player.global_transform.origin - global_transform.origin
		direction = direction.normalized()
		translate(direction * move_speed * delta)

func set_following(player):
	state = "FOLLOWING"
	self.player = player
