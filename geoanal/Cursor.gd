extends Node2D

var globalPosition_i: Vector2 #guarda a posicao do clique do mouse no mundo
var mousePosition_i: Vector2 #guarda a posicao do clique do mouse na janela
var globalPosition_f: Vector2
var arrowColor:= Color.black


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	_end_line()

func _process(delta):
	update()
	position = get_global_mouse_position()
	get_input()
	var v_length = (globalPosition_i-globalPosition_f).length()
	arrowColor.r = 0.1 + (v_length/1300)
	arrowColor.g = 0.1 + (v_length/1600)
	arrowColor.b = 0.1 + (v_length/1400)


func get_input():
	if Input.is_action_just_pressed("click_right"):
		_ready_to_draw()
	if Input.is_action_just_released("click_right"):
		_end_line()

func _ready_to_draw():
	arrowColor.a = 1
	globalPosition_i =  get_local_mouse_position()
	mousePosition_i = get_viewport().get_mouse_position()

func _draw():
	globalPosition_f = globalPosition_i - mousePosition_i + get_viewport().get_mouse_position() #just breaking this into 2
	var position_linha = globalPosition_i + (globalPosition_f - globalPosition_i)
	draw_line(-position_linha, Vector2.ZERO, arrowColor, 1.5)

func _end_line():
	arrowColor.a = 0
	update()

