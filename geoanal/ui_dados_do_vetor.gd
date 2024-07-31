extends RichTextLabel

var globalPosition_i: Vector2 #guarda a posicao do clique do mouse no mundo
#var mousePosition_i: Vector2 #guarda a posicao do clique do mouse na janela
var globalPosition_f: Vector2
var v_length = Vector2.ZERO

func get_input():
	if Input.is_action_just_pressed("click_right"):
		globalPosition_i =  get_local_mouse_position()
		visible = true
	elif Input.is_action_just_released("click_right"):
		visible = false


func _process(delta):
	get_input()
	#globalPosition_f = globalPosition_i - mousePosition_i + get_viewport().get_mouse_position()
	globalPosition_f = get_global_mouse_position() - globalPosition_i
	v_length = (globalPosition_f).length()
	bbcode_text = ("x: ") + String(globalPosition_f.x).pad_decimals(2) + ("\ny: ") + String(-globalPosition_f.y).pad_decimals(2) +("\nlength: ") + String(v_length).pad_decimals(2) + ("\nangle: ") + String(globalPosition_f.angle()*-180/PI).pad_decimals(2)
