extends Node2D

func _ready():
	$Sprite.playing = true
	$Sprite.speed_scale = 0.5
	if (global.rank == "p"):
		$Timer.wait_time = 10
	else:
		$Timer.wait_time = 8.5
	$Timer.start()
	
func _process(delta):
	if ($Sprite.frame == $Sprite.frames.get_frame_count($Sprite.animation) - 1):
		$Sprite.speed_scale = 0
	if (utils.get_player().character == "P"):
		if (global.rank == "p"):
			$Sprite.animation = "rankP"
		if (global.rank == "s"):
			$Sprite.animation = "rankS"
		if (global.rank == "a"):
			$Sprite.animation = "rankA"
		if (global.rank == "b"):
			$Sprite.animation = "rankB"
		if (global.rank == "c"):
			$Sprite.animation = "rankC"
		if (global.rank == "d"):
			$Sprite.animation = "rankD"
	else:
		if (global.rank == "s" || global.rank == "p"):
			$Sprite.animation = "rankNS"
		if (global.rank == "a"):
			$Sprite.animation = "rankNA"
		if (global.rank == "b"):
			$Sprite.animation = "rankNB"
		if (global.rank == "c"):
			$Sprite.animation = "rankNC"
		if (global.rank == "d"):
			$Sprite.animation = "rankND"
	$Sprite.material.set_shader_param("current_palette", global.peppalette)

func _on_Timer_timeout():
	utils.stopsound("RankP")
	utils.stopsound("RankS")
	utils.stopsound("RankA")
	utils.stopsound("RankC")
	utils.stopsound("RankD")
	global.roomtorestart = ""
	global.leveltorestart = ""
	utils.get_player().scr_playerreset()
	utils.room_goto("", "hub_room1")
	queue_free()
