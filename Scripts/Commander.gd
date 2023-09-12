extends Node

class_name Commander

var ui: Node
var parent: CharacterBody3D

var bbs: Array[BattleBit] = []


func _init(_parent: CharacterBody3D):
	parent = _parent

func _add_battle_bit(bb: BattleBit):
	if bbs.size() < Globals.MAX_BB:
		bbs.push_back(bb)
	else:
		print("no more bbs allowed")
