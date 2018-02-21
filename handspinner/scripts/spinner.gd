extends Node2D

var vel = 0
var acel = -1
signal speed(valor)
signal limit
var block = false
signal zero

func _ready():
	set_process(true)

func _process(delta):
	if vel > 1:
		vel += acel * delta
	else:
		vel = 0
		acel = -2
		if block:
			emit_signal("zero")
		print("vel = 0")
	get_node("Corpo/Sprite").set_rot(get_node("Corpo/Sprite").get_rot() + delta*vel)
	emit_signal("speed", vel/50)

func _on_Contato_input_event( viewport, event, shape_idx ):
	if event.type == InputEvent.SCREEN_TOUCH and event.pressed and not block:
		vel += 5
		print("press+5")
	if vel > 50:
		vel = 50
		emit_signal("limit")
		print("vel=50")


func _on_btnBlack_pressed():
	get_node("Corpo/Sprite").set_texture(load("res://assets/black_ready.png"))


func _on_btnRed_pressed():
	get_node("Corpo/Sprite").set_texture(load("res://assets/red_ready.png"))


func _on_btnYellow_pressed():
	get_node("Corpo/Sprite").set_texture(load("res://assets/yellow_ready.png"))


func _on_Game_block():
	block = true
	acel = -10


func _on_Game_unblock():
	block = false
