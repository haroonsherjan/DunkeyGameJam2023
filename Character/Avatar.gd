extends CharacterBody2D

var health : int = 20
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var damage = 0
var hurt = false

func _physics_process(delta):
	apply_damage(delta)
	move()
	actions()
	
func actions():
	if Input.is_action_just_pressed("ui_accept"):
		$FollowerInventory.equip_follower()

func move():
	if not hurt:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
		var x_direction = Input.get_axis("ui_left", "ui_right")
		if x_direction:
			velocity.x = x_direction * SPEED
		else:
			var y_direction = Input.get_axis("ui_up", "ui_down")
			if y_direction:
				velocity.y = y_direction * SPEED
	move_and_slide()


func apply_damage(delta)->void:
	if self.health <= 0:
		queue_free()
	self.health -= self.damage * delta
	self.damage = 0

func _on_hurtbox_body_entered(body:Node2D):
	if not hurt:
		hurt = true
		$Hurtbox/HurtTimer.start()
		velocity.x *= -1
		velocity.y *= -1
	self.damage += body.damage


func _on_hurt_timer_timeout():
	hurt = false
