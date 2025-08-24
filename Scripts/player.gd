extends CharacterBody2D

const SPEED = 200
const JUMP_VELOCITY = -400.0

const maxPlayerHealth : float = 100;
var playerHealth : float = 100;

@onready var attackArea: Area2D = $Attack_CollisionShape
@onready var coyote_timer: Timer = $CoyoteTimer
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var attack_timer: Timer = $Attack_CollisionShape/AttackTimer
@onready var gameplay_gui: Control = $"../CanvasLayer/GameplayGui"



var canJump : bool = false
var isAttacking : bool = false


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		if canJump and coyote_timer.is_stopped():
			coyote_timer.start()
		else:
			velocity += get_gravity() * delta
	else:
		canJump = true
		

	# Handle jump.
	if Input.is_action_just_pressed("jump") and canJump:
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	
	if(not isAttacking):
		if(direction == 0):
			animated_sprite.play("IDLE")
		else:
			animated_sprite.play("WALK")
	
	if(direction > 0):
		# looking to right
		attackArea.position.x = abs(attackArea.position.x)
		animated_sprite.flip_h = false
		pass
	elif(direction < 0):
		# looking to left
		attackArea.position.x = abs(attackArea.position.x) * -1
		animated_sprite.flip_h = true
		pass
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func ModifyHealth(health_points: int):
	var old_player_health := playerHealth
	
	playerHealth += health_points
	playerHealth = min(playerHealth, maxPlayerHealth)
	
	var health_gained_percentage = (playerHealth - old_player_health) / maxPlayerHealth
	
	gameplay_gui.update_health_bar(health_gained_percentage)

func _on_coyote_timer_timeout() -> void:
	canJump = false

func _input(event: InputEvent) -> void:
	if(event.is_action_pressed("attack") and not isAttacking):
		isAttacking = true
		animated_sprite.play("ATTACK")
		attack_timer.start()

func _on_attack_timer_timeout() -> void:
	isAttacking = false
