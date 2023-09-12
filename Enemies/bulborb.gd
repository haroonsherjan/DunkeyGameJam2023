extends CharacterBody3D

const SPEED := 1.5

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var animator = $AnimationPlayer
@onready var player_detection = $DetectPlayer
@onready var player = get_parent().get_node("TestPlayer")

var is_following = false

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		self.velocity.y -= gravity * delta
	
	if is_following and player:
		var direction = (player.position - position).normalized()
		direction.y = 0
		look_at(global_position + direction, Vector3.UP)
		rotate_object_local(Vector3.UP, PI)
		if direction:
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)
	else:
		velocity.x = 0
		velocity.z = 0
		
	if velocity.x > 0 or velocity.z > 0 or is_following == true:
		animator.play("Walking")
	else:
		animator.play("Armature_001")

	move_and_slide()

func _on_detect_player_body_entered(body):
	if body.name == "TestPlayer":
		is_following = true


func _on_detect_player_body_exited(body):
	if body.name == "TestPlayer":
		is_following = false
