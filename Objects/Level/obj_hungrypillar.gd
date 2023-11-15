extends KinematicBody2D

func _ready():
	$Sprite.speed_scale = 0.35
	$Sprite.playing = true
	z_index = -2
	if (global.saveroom.has(global.targetRoom + name)):
		queue_free()
	
func destroy():
	if (!global.saveroom.has(global.targetRoom + name)):
		for i in get_tree().get_nodes_in_group("obj_escapecollect"):
			utils.instance_create(i.position.x, i.position.y, "res://Objects/Visuals/obj_genericpoofeffect.tscn")
		utils.playsound("EscapeRumble")
		for i in get_tree().get_nodes_in_group("obj_camera"):
			i.panictimer.start()
		utils.playsound("KillEnemy")
		utils.instance_create(global_position.x, global_position.y, "res://Objects/Visuals/obj_bangeffect.tscn")
		utils.instance_create(global_position.x, global_position.y, "res://Objects/Visuals/obj_slapstar.tscn")
		utils.instance_create(global_position.x, global_position.y, "res://Objects/Visuals/obj_slapstar.tscn")
		utils.instance_create(global_position.x, global_position.y, "res://Objects/Visuals/obj_slapstar.tscn")
		utils.instance_create(global_position.x, global_position.y, "res://Objects/Baddies/obj_baddiegibs.tscn")
		utils.instance_create(global_position.x, global_position.y, "res://Objects/Baddies/obj_baddiegibs.tscn")
		utils.instance_create(global_position.x, global_position.y, "res://Objects/Baddies/obj_baddiegibs.tscn")
		for obj in get_tree().get_nodes_in_group("obj_camera"):
			obj.shake_mag = 3
			obj.shake_mag_acc = 0.1
		var deadbaddieid = utils.instance_create(global_position.x, global_position.y, "res://Objects/Baddies/obj_sausageman_dead.tscn")
		deadbaddieid.sprite_index = $Sprite.frames.get_frame("hungrypillar_dead", 0)
		global.combotime = 60
		global.panic = true
		utils.instance_create(global_position.x, global_position.y + 600, "res://Objects/Visuals/obj_itspizzatime.tscn")
		match global.targetLevel:
			"entrance":
				global.minutes = 2
				global.seconds = 30
			"medieval":
				global.minutes = 2
				global.seconds = 15
			"ruin":
				global.minutes = 3
				global.seconds = 30
			"dungeon":
				global.minutes = 3
				global.seconds = 30
			"chateau":
				global.minutes = 2
				global.seconds = 15
			_:
				global.minutes = 3
				global.seconds = 30
		global.saveroom.append(global.targetRoom + name)
		queue_free()
