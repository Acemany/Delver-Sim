extends CharacterBody2D

@export var SPEED = 150.0
@export var MAX_SPEED = 200.0

@onready var label_money = $CanvasLayer/Control/Label
@onready var button_up = $CanvasLayer/Control/ButtonUp
@onready var button_down = $CanvasLayer/Control/ButtonDown
@onready var button_left = $CanvasLayer/Control/ButtonLeft
@onready var button_right = $CanvasLayer/Control/ButtonRight
@onready var sprite_animated = $SpriteAnimated

var direction: Vector2
var button_direction: Vector2
var prev_angl: int
var angl: int = 5
enum ANGLES {RIGHT, DOWN, LEFT, UP}

func _ready():
	$ShapeView.polygon = $ShapeCollision.polygon
	update_sprite()

func _process(delta: float):
	button_direction = Vector2(int(button_right.is_pressed())-int(button_left.is_pressed()), int(button_down.is_pressed())-int(button_up.is_pressed()))
	if button_direction == Vector2.ZERO:
		direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	else:
		direction = button_direction
	if direction:
		velocity = velocity.move_toward(MAX_SPEED*direction, SPEED*delta*16)
	if direction == Vector2.ZERO:
		velocity = velocity.move_toward(Vector2.ZERO, SPEED*delta*16)
	move_and_slide()

	update_sprite(direction)

func _input(event: InputEvent):
	if event.is_action("ui_cancel"):
		get_tree().quit()


func update_sprite(dir: Vector2 = Vector2.ZERO):
	prev_angl = int(fmod(((get_global_mouse_position()-global_position).angle()/PI*2+4.5), 4))\
				if dir == Vector2.ZERO else 0 if dir.x > 0 else \
											2 if dir.x < 0 else \
											1 if dir.y > 0 else 3

	if prev_angl != angl:
		angl = prev_angl
		sprite_animated.flip_h = angl <= 1
	sprite_animated.play("%s%s" % ["Idle" if dir == Vector2.ZERO else "Run",
								   "Side" if not angl % 2 else
								   "Up" if angl == ANGLES.UP else "Down"])
