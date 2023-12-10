extends Area2D

var maxspeed = 1

func _ready():
	modulate.a = 0
	position.x = utils.get_player().position.x
	position.y = utils.get_player().position.y
	$Sprite.playing = true
	$Sprite.speed_scale = 0.35
	$AfterImageTimer.start()
	
func room_start():
	position.x = utils.get_player().position.x
	position.y = utils.get_player().position.y
	modulate.a = 0
	maxspeed = 1
	if (global.targetRoom == "rank_room"):
		destroy()
		
func _process(delta):
	var obj_player = utils.get_player()
	if (modulate.a >= 1):
		# This is stupid.
		if (position.x < obj_player.position.x):
			position.x += maxspeed
		if (position.x > obj_player.position.x):
			position.x -= maxspeed
		if (position.y < obj_player.position.y):
			position.y += maxspeed
		if (position.y > obj_player.position.y):
			position.y -= maxspeed
	else:
		modulate.a += 0.01
	if (overlaps_body(obj_player) && !utils.instance_exists("obj_fadeout") && !utils.instance_exists("obj_endlevelfade") && modulate.a >= 1):
		global.targetDoor = "A"
		obj_player.state = global.states.timesup
		obj_player.set_animation("timesup")
		for i in get_tree().get_nodes_in_group("obj_music"):
			i.musicnode.stop()
			i.secretmusicnode.stop()
		utils.room_goto("", "timesuproom")
		utils.playsound("TimesUp")
		destroy()
	if (modulate.a >= 1):
		maxspeed += 0.01

func destroy():
	var shakeeffect = utils.instance_create_level(position.x, position.y, "res://Objects/Visuals/obj_shakeanddie.tscn")
	shakeeffect.sprite = $Sprite.frames.get_frame($Sprite.animation, 0)
	utils.playsound("Explosion")
	utils.playsound("Groundpound")
	queue_free()

func _on_AfterImageTimer_timeout():
	var afterimage = utils.instance_create_level(position.x, position.y, "res://Objects/Visuals/obj_afterimage.tscn")
	afterimage.sprite = $Sprite.frames.get_frame($Sprite.animation, $Sprite.frame)
	afterimage.scale.x = scale.x
	$AfterImageTimer.start()
