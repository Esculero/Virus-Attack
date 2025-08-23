extends RigidBody2D

const STARTING_HEALTH := 100
const SPEED_X := 30

@onready var animated_sprite := $AnimatedSprite2D

@onready var raycast_right = $RayCast2D_Right
@onready var raycast_left = $RayCast2D_Left

@onready var raycast_right_down = $RayCast2D_Right_Down
@onready var raycast_left_down = $RayCast2D_Left_Down

var health_points := STARTING_HEALTH
var direction := 1


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	if health_points <= 0:
		queue_free()
	
	position.x += delta * SPEED_X * direction
	
	if direction == 1:
		if raycast_right.is_colliding() or !raycast_right_down.is_colliding():
			flip()
	else:
		if raycast_left.is_colliding() or !raycast_left_down.is_colliding():
			flip()
	
func take_damage(other: Node2D, hit_points: int):
	health_points -= hit_points
	
	animated_sprite.play("damaged")
	print(other.name, " hit ", self.name)

func flip():
	direction *= -1
	animated_sprite.flip_h = !animated_sprite.flip_h
	


func _on_animated_sprite_2d_animation_finished() -> void:
	animated_sprite.play("idle")
