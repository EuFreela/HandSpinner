extends Node2D

var score1 = 0
var score2 = 0
signal block
var spinner1ok = false
var spinner2ok = false
var resetando
var time
signal unblock

func _ready():
	pass

func atualizaScore():
	get_node("Control/Panel/Player1/Score").set_text(str(score1))
	get_node("Control/Panel/Player2/Score").set_text(str(score2))
	emit_signal("block")

func _on_Spinner1_limit():
	score1 += 1
	get_node("Control/Panel/Player1/Msg").set_text("Você Ganhou!")
	get_node("Control/Panel/Player2/Msg").set_text("Você Perdeu!")
	atualizaScore()

func _on_Spinner2_limit():
	score2 += 1
	get_node("Control/Panel/Player1/Msg").set_text("Você Perdeu!")
	get_node("Control/Panel/Player2/Msg").set_text("Você Ganhou!")
	atualizaScore()


func _on_Spinner1_zero():
	spinner1ok = true
	if spinner2ok:
		reset()


func _on_Spinner2_zero():
	spinner2ok = true
	if spinner1ok:
		reset()

func reset():
	if resetando: return
	resetando = true
	get_node("Control/Panel/Player1/Msg").set_text("")
	get_node("Control/Panel/Player2/Msg").set_text("")
	time = 5
	get_node("EntreRound").start()

func _on_EntreRound_timeout():
	time -= 1
	if time > 1:
		get_node("Control/Panel/Player1/Msg").set_text(str(time-1))
		get_node("Control/Panel/Player2/Msg").set_text(str(time-1))
	if time == 1:
		get_node("Control/Panel/Player1/Msg").set_text(str("GO!"))
		get_node("Control/Panel/Player2/Msg").set_text(str("GO!"))
		resetando = false
		emit_signal("unblock")
	if time == 0:
		get_node("Control/Panel/Player1/Msg").set_text("")
		get_node("Control/Panel/Player2/Msg").set_text("")
