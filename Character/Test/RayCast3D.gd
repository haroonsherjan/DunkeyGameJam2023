extends RayCast3D

var can_interact = false
var interactable: Interactable

func _input(_event):
	if Input.is_action_pressed("Interact") and interactable:
		interactable.interacted.emit()

func _physics_process(_delta):
	if is_colliding():
		interactable = get_collider()
		
		if interactable is Interactable:
			can_interact = true
		else:
			can_interact = false
			interactable = null
	else:
		can_interact = false
		interactable = null
