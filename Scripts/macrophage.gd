extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

@onready var attack_timer: Timer = $AttackTimer

const JUMP_VELOCITY := Vector2(150, -200)
const ATTACK_INTERVAL_SECONDS := 1.0

var must_jump := false
var must_land := false
var can_attack := true

var direction := 1.0

var player_body = null

func _ready() -> void:
	attack_timer.start(ATTACK_INTERVAL_SECONDS)

func _process(delta: float) -> void:
	pass
	
func flip() -> void:
	direction *= -1
	animated_sprite.flip_h = not animated_sprite.flip_h

func jump() -> void:
	if player_body != null:
		var new_direction = sign(player_body.position.x - position.x)
	
		if new_direction != direction:
			flip()
	else:
		flip()
		
	
	velocity.x += JUMP_VELOCITY.x * direction
	velocity.y += JUMP_VELOCITY.y
	
	must_jump = false

	animated_sprite.play("jumping")

func attack(body: Node2D) -> void:
	body.ModifyHealth(10)
	print(name, " attacks player ", body)

func _physics_process(delta: float) -> void:
	if is_on_floor() && must_jump:
		jump()
		
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if is_on_floor():
		if must_land:
			animated_sprite.play("idle")
			
			must_land = false
	else:
		if not must_land:
			must_land = true
		
	if is_on_floor():
		velocity.x *= 0.8

	move_and_slide()


func _on_jump_timer_timeout() -> void:
	must_jump = true


func _on_animated_sprite_2d_animation_finished() -> void:
	if not is_on_floor():
		animated_sprite.play("idle")


func _on_spotting_zone_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_body = body


func _on_spotting_zone_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_body = null


func _on_attack_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if can_attack:
			attack(body)


func _on_attack_timer_timeout() -> void:
	can_attack = true
