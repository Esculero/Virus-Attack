extends Node2D

var health_points := 100


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	if health_points <= 0:
		queue_free()
	
func take_damage(other: Node2D, hit_points: int):
	health_points -= hit_points
	
	$AnimatedSprite2D.play("damaged")
	print(other.name, " hit ", self.name)
