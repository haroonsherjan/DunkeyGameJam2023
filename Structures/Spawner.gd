extends Node3D

@onready var commander: Commander = (get_parent().get_node("TestPlayer") as Player).commander

func _on_interactable_interacted():
	var BBScene = load("res://Pikmin/BattleBit.tscn")
	var BBInstance: BattleBit = BBScene.instantiate()
	BBInstance.position.x = position.x + RandomNumberGenerator.new().randf_range(-5, 5)
	BBInstance.position.y = 1
	BBInstance.init(commander)
	get_parent().add_child(BBInstance)
