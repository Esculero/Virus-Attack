extends Node2D

var health_points := 100

@onready var animated_script := $AnimatedSprite2D


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	if health_points <= 0:
		queue_free()
	
func take_damage(other: Node2D, hit_points: int):
	health_points -= hit_points
	
	animated_script.play("damaged")
	print(other.name, " hit ", self.name)


func _on_animated_sprite_2d_animation_finished() -> void:
	animated_script.play("idle")
