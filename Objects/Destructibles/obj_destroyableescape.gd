extends StaticBody2D

func _ready():
	if (global.escaperoom.has(global.targetRoom + name)):
		queue_free()
	if (!global.panic):
		queue_free()
	
func destroy():
	var debris1 = utils.instance_create_level(global_position.x + 16, global_position.y + 16, "res://Objects/Visuals/obj_debris.tscn")
	debris1.sprite_index = "debrisescape"
	var debris2 = utils.instance_create_level(global_position.x + 16, global_position.y + 16, "res://Objects/Visuals/obj_debris.tscn")
	debris2.sprite_index = "debrisescape"
	var debris3 = utils.instance_create_level(global_position.x + 16, global_position.y + 16, "res://Objects/Visuals/obj_debris.tscn")
	debris3.sprite_index = "debrisescape"
	var debris4 = utils.instance_create_level(global_position.x + 16, global_position.y + 16, "res://Objects/Visuals/obj_debris.tscn")
	debris4.sprite_index = "debrisescape"
	if (utils.soundplaying("BreakBlock1") || utils.soundplaying("BreakBlock2")):
		utils.stopsound("BreakBlock1")
		utils.stopsound("BreakBlock2")
	var rng = utils.randi_range(1,2)
	if (rng == 1):
		utils.playsound("BreakBlock1")
	elif (rng == 2):
		utils.playsound("BreakBlock2")
	global.escaperoom.append(global.targetRoom + name)
	var pizzacoin = utils.randi_range(1, 100)
	if (pizzacoin >= 95):
		var pizzacoininst = utils.instance_create_level(global_position.x, global_position.y, "res://Objects/Collectibles/obj_pizzacoin.tscn")
		pizzacoininst.velocity.x = 2
	queue_free()
