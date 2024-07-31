extends KinematicBody2D

export var gravity = 1200.0
export var _speed: = Vector2(2.2,2.2)

var _velocity: = Vector2.ZERO
var global_position_i: Vector2#guarda a posicao do clique do mouse
var global_position_f: Vector2#guarda a posicao de quando solta o mouse

var last_position = Vector2(480,320)
var new_position = Vector2(480,320)

var enable_mov: bool #se true o player pode comandar o personagem
var mousehold: bool = false#eh true se o player esta segurando o botao do mouse

onready var camera = $Camera2D
onready var trail = $Line2D

func _ready():
	trail.set_as_toplevel(true)

#***********************************************
func _physics_process(delta: float) -> void:
	_velocity.y += gravity * delta#aplicando a gravidade
	trail.add_point(global_position)
	if is_on_floor():
		enable_mov = true
		_velocity.x *= 0.5
		if _velocity.x <= 1 and (abs(new_position.x - global_position.x)>32):
			last_position = new_position
			new_position = global_position
	elif is_on_ceiling():#detecta se o player esta no teto
		_velocity.y = 20 #max(_velocity.y, -_velocity.y) * 0.3#se o player estiver no teto ele ganha velocidade em y para cair e nao grudar la
	elif is_on_wall():#bounce bounce (on walls)
		_velocity.x *= -0.5#coeficiente de bounce
	_get_input()
	move_and_slide(_velocity, Vector2.UP)
	
	

func _get_input():
	if Input.is_action_just_pressed("click_right"):#guarda a posicao do clique do mouse
		global_position_i = get_viewport().get_mouse_position()
		mousehold = true
	if Input.is_action_just_released("click_right"):#guarda a posicao de quando solta o mouse
		mousehold = false#quando solta o botao, mouse hold vira falso
		if enable_mov:
			global_position_f = get_viewport().get_mouse_position()
			var position_linha = global_position_i + ((global_position_f - global_position_i))
			_velocity = _speed * calculate_impulse(global_position_i, position_linha)#aplica o impulso a velocidade assim que o player solta o mouse
			enable_mov = false#assim que o player aplica o impulso, ele perde o controle do personagem
			trail.clear_points()
	if Input.is_action_just_pressed("ui_left") and enable_mov:
		position = last_position
		trail.clear_points()

func calculate_impulse(vi: Vector2, vf: Vector2) -> Vector2:#calcula o impulso a partir das cordenadas do mouse
	var impulse: Vector2
	impulse = (vf-vi)
	return impulse
#***********************************************
