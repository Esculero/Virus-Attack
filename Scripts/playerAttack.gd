extends Area2D

@onready var attackArea: Area2D = $"."
var targetedEnemies: Array

const lightDamage: int = 15;

var isAttacking : bool = false


@onready var audio_stream_player_2d: AudioStreamPlayer2D = $"../AudioStreamPlayer2D"
const SLAP = preload("res://Assets/sounds/slap.mp3")

func _process(_delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if (event.is_action_pressed("attack") and not isAttacking):
		isAttacking = true
		if(targetedEnemies.size() > 0):
			audio_stream_player_2d.stream = SLAP
			audio_stream_player_2d.play()
			pass
			
		for enemy in targetedEnemies:
			# damage the enemy
			if enemy.has_method("take_damage"):
				enemy.take_damage(self, lightDamage)


func _on_body_entered(body: Node2D) -> void:
	print(body.name, " entered player's attack zone")
	if (body.is_in_group("enemies")):
		targetedEnemies.append(body)


func _on_body_exited(body: Node2D) -> void:
	print(body.name, " exited player's attack zone")
	if (targetedEnemies.has(body)):
		targetedEnemies.erase(body)


func _on_attack_timer_timeout() -> void:
	isAttacking = false
