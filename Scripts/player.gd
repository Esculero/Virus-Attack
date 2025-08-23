extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

const maxPlayerHealth : int = 100;
var playerHealth : int = 100;

@onready var attackArea: Area2D = $Attack_CollisionShape
@onready var coyote_timer: Timer = $CoyoteTimer

var canJump : bool = false


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
	
	if(direction > 0):
		# looking to right
		attackArea.position.x = abs(attackArea.position.x)
		pass
	elif(direction < 0):
		# looking to left
		attackArea.position.x = abs(attackArea.position.x) * -1
		pass
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _on_coyote_timer_timeout() -> void:
	canJump = false
