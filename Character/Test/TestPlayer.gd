class_name Player
extends CharacterBody3D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

# References
var ui
var commander: Commander

# Movement
var twist_input := 0.0
var pitch_input := 0.0

# Stats
var health = Globals.PLAYER_MAX_HEALTH


func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	$"CameraTwistPivot/CameraPitchPivot/Camera3D/Player UI/HealthBar".value = health
	commander = Commander.new(self)
	
func _process(_delta):
	update_ui()

func _input(_ev):
	if Input.is_action_just_pressed("close"):
		get_tree().quit()
		
func _unhandled_input(event):
	if event is InputEventMouseMotion:
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			twist_input = - event.relative.x * Globals.MOUSE_SENSITIVITY
			pitch_input = - event.relative.y * Globals.MOUSE_SENSITIVITY

func _physics_process(delta):
	$CameraTwistPivot.rotate_y(twist_input)
	$CameraTwistPivot/CameraPitchPivot.rotate_x(pitch_input)
	$CameraTwistPivot/CameraPitchPivot.rotation.x = clamp(
		$CameraTwistPivot/CameraPitchPivot.rotation.x,
		-0.7,
		-0.15
	)
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "forwards", "backwards")
	
	var direction = ($CameraTwistPivot.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * Globals.CHARACTER_SPEED
		velocity.z = direction.z * Globals.CHARACTER_SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, Globals.CHARACTER_SPEED)
		velocity.z = move_toward(velocity.z, 0, Globals.CHARACTER_SPEED)
	
	move_and_slide()
	twist_input = 0.0
	pitch_input = 0.0
	
	
func update_ui():
	$"CameraTwistPivot/CameraPitchPivot/Camera3D/Player UI/HealthBar".value = health
	$"CameraTwistPivot/CameraPitchPivot/Camera3D/Player UI/CurrentBBCount".clear()
	$"CameraTwistPivot/CameraPitchPivot/Camera3D/Player UI/CurrentBBCount".add_text(str(commander.bbs.size()))
	
func update_health(health_delta: int):
	health = clamp(health + health_delta, 0, Globals.PLAYER_MAX_HEALTH)
	ui.get_node("HealthBar").value = health
	if health == 0:
		print("Add support for player death")
