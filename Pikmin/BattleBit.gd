extends CharacterBody3D

class_name BattleBit

var commander: Commander

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


var is_following := false


func init(_commander: Commander):
	commander = _commander
	commander._add_battle_bit(self)
	is_following = true

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	if is_following and commander.parent:
		var distance = commander.parent.position - position
		var direction = (distance).normalized()
		if abs(distance.x) > Globals.BB_FOLLOW_DISTANCE or abs(distance.z) > Globals.BB_FOLLOW_DISTANCE:
			velocity.x = direction.x * Globals.BB_SPEED
			velocity.z = direction.z * Globals.BB_SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, Globals.BB_SPEED)
			velocity.z = move_toward(velocity.z, 0, Globals.BB_SPEED)

	move_and_slide()
