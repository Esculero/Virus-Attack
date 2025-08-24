extends RigidBody2D

const STARTING_HEALTH := 100.0
const SPEED_X := 30.0
const MAXIMUM_MOVEMENT_AREA := 50.0

@onready var raycast_right = $RayCast2D_Right
@onready var raycast_left = $RayCast2D_Left

@onready var raycast_right_down = $RayCast2D_Right_Down
@onready var raycast_left_down = $RayCast2D_Left_Down

var health_points := STARTING_HEALTH
var direction := 1.0
var movement_area := MAXIMUM_MOVEMENT_AREA / 2


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	if health_points <= 0:
		queue_free()
		return

	var delta_x := delta * SPEED_X

	position.x += delta_x * direction
	movement_area += delta_x

	var do_flip := false

	if direction == 1:
		if raycast_right.is_colliding() or not raycast_right_down.is_colliding():
			do_flip = true
	else:
		if raycast_left.is_colliding() or not raycast_left_down.is_colliding():
			do_flip = true

	if movement_area >= MAXIMUM_MOVEMENT_AREA:
		do_flip = true

	if do_flip:
		flip()

func take_damage(_other: Node2D, hit_points: int) -> void:
	health_points -= hit_points

	for sprite in $Sprites.get_children():
		sprite.play("damaged")

func flip() -> void:
	direction *= -1
	movement_area = 0.0

	for sprite in $Sprites.get_children():
		sprite.flip_h = not sprite.flip_h


func _on_animated_sprite_2d_animation_finished() -> void:
	for sprite in $Sprites.get_children():
		sprite.play("idle")
