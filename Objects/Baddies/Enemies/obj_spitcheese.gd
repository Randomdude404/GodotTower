extends obj_baddie

func _ready():
	grav = 0.5
	velocity.x = 0
	velocity.y = 0
	movespeed = 0
	state = global.states.walk
	stunned = 0
	straightthrow = false
	spr_idle = "idle"
	spr_stunfall = "stun"
	spr_walk = "idle"
	spr_grabbed = "stun"
	spr_scared = "stun"
	spr_dead = "dead"
	hp = 2
	bombreset = 0
	important = false
	
func _process(delta):
	match state:
		global.states.idle:
			scr_enemy_idle()
		global.states.turn:
			scr_enemy_turn()
		global.states.walk:
			scr_enemy_walk()
		global.states.land:
			scr_enemy_land()
		global.states.hit:
			scr_enemy_hit()
		global.states.stun:
			scr_enemy_stun()
		global.states.charge:
			scr_enemy_charge()
		global.states.pizzagoblinthrow:
			scr_pizzagoblin_throw()
		global.states.grabbed:
			scr_enemy_grabbed()
	var obj_player = utils.get_player()
	if (state != global.states.grabbed):
		z_index = 0
	if (state != global.states.stun):
		thrown = false
	if (bombreset > 0):
		bombreset -= 1
	if (position.x != obj_player.position.x && state != global.states.pizzagoblinthrow && bombreset == 0):
		if (obj_player.position.x > (position.x - 400) && obj_player.position.x < (position.x + 400) && position.y <= (obj_player.position.y + 20) && position.y >= (obj_player.position.y - 20)):
			if (state == global.states.walk || state == global.states.idle):
				state = global.states.pizzagoblinthrow
