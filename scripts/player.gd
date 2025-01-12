extends CharacterBody2D

@export var SPEED = 75.0
@export var MAX_SPEED = 100.0

@onready var label_money = $UI/Control/LabelMoney
@onready var joystick: Joystick = $UI/Control/Joypad
@onready var sprite_animated = $SpriteAnimated

enum ANGLES {RIGHT, DOWN, LEFT, UP}

var direction: Vector2
var button_direction: Vector2
var prev_speed: String
var prev_angl: int
var angl: int = 5

func _ready():
	update_sprite()

func _process(delta: float):
	if button_direction.is_zero_approx():
		direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
		direction /= max(sin(fmod(direction.angle(), PI/2)),cos(fmod(direction.angle(), PI/2)))
	else:
		direction = button_direction
	if direction:
		velocity = velocity.move_toward(MAX_SPEED*direction, SPEED*delta*16)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, SPEED*delta*16)
	move_and_slide()

	update_sprite(direction)

func _input(event: InputEvent):
	if event.is_action("ui_cancel"):
		get_tree().quit()


func update_sprite(dir: Vector2 = Vector2.ZERO):
	prev_angl = int(fmod(((get_global_mouse_position()-global_position).angle()/PI*2+4.5), 4))\
				if dir == Vector2.ZERO else\
				ANGLES.RIGHT if dir.x > 0 else ANGLES.LEFT\
				if dir.x < 0 else\
				ANGLES.DOWN if dir.y > 0 else ANGLES.UP

	if angl != prev_angl or prev_speed != ("Idle" if dir.is_zero_approx() else "Run"):
		prev_speed = "Idle" if dir.is_zero_approx() else "Run"
		angl = prev_angl
		sprite_animated.play("%s%s" % [prev_speed,
									   "Left" if angl == ANGLES.LEFT else
									   "Right" if angl == ANGLES.RIGHT else
									   "Up" if angl == ANGLES.UP else "Down"])
