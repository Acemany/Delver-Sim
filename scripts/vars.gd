extends Node

const SKINS: Resource = preload("res://resources/skins.tres")
var SKIN_DICT: Dictionary = {}
var money: int = 0

func _ready() -> void:
	for i in SKINS.skins:
		SKIN_DICT[i.resource_name] = i


func save_game():
	pass


func load_game():
	pass
