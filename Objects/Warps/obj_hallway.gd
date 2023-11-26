extends Node2D

export(String) var targetDoor = "A"
export(String) var targetLevel = "testroom"
export(String) var targetRoom = "testroom_1"

func _ready():
	if global.targetDoor != "" && global.targetDoor == targetDoor:
		var obj_player = utils.get_player()
		var hallwaydirection = sign(scale.x)
		obj_player.position.x = ($SpawnPoint.global_position.x + (-hallwaydirection * 100))
		obj_player.position.y = ($SpawnPoint.global_position.y - 14)
		obj_player.roomstartx = obj_player.position.x
		obj_player.roomstarty = obj_player.position.y
		obj_player.xscale = (-sign(scale.x))


func _on_obj_hallway_body_entered(body):
	if body is obj_player:
		if (!utils.instance_exists("obj_fadeout")):
			var obj_player = utils.get_player()
			obj_player.targetRoom = targetRoom
			obj_player.targetLevel = targetLevel
			global.targetDoor = targetDoor
			if (obj_player.state == global.states.machslide):
				obj_player.state = global.states.normal
			if (obj_player.state == global.states.grab):
				obj_player.state = global.states.normal
				obj_player.baddiegrabbed = ""
			utils.playsound("Door")
			utils.instance_create(utils.get_gamenode().global_position.x, utils.get_gamenode().global_position.y, "res://Objects/Visuals/obj_fadeout.tscn")
