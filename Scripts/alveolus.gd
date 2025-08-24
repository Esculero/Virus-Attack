extends Node2D

const maxHealth : int = 100
var health : int = 100

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
const ALVEOLUS_POP = preload("res://Assets/sounds/alveolusPop.mp3")

@onready var hit_timer: Timer = $hitTimer
@onready var gameplay_gui: Control = $"../../CanvasLayer/GameplayGui"


func _ready() -> void:
	animated_sprite_2d.play("healthy")
	gameplay_gui.update_alveoli_count(+1)

func take_damage(_other: Node2D, damage: int):
	if health <= 0 : return
	
	health -= damage
	
	print("Received ", damage, " damage.")
	print("Current hp: ", health)
	
	animated_sprite_2d.material.set("shader_parameter/tint_factor", 0.5)
	hit_timer.start()
	
	if(health <= 0):
		# destroyed
		animated_sprite_2d.play("destroyed")
		audio_stream_player_2d.stream = ALVEOLUS_POP
		audio_stream_player_2d.play()
		
		gameplay_gui.update_alveoli_count(-1)
		return
		pass
	
	var healthProc = float(health) / maxHealth
	
	if(healthProc > 0.8):
		# damaged1
		animated_sprite_2d.play("damaged1")
		pass
	elif (healthProc > 0.3):
		# damaged2
		animated_sprite_2d.play("damaged2")
		pass
	

func _on_hit_timer_timeout() -> void:
	animated_sprite_2d.material.set("shader_parameter/tint_factor", 0.0)
