extends Area2D

@onready var attackArea: Area2D = $"."
var targetedEnemies: Array

const lightDamage: int = 15;

func _process(_delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if (event.is_action("attack")):
		for enemy in targetedEnemies:
			# damage the enemy
			print("I'm trying to attack ", enemy.name)
			if enemy.has_method("take_damage"):
				enemy.take_damage(self, lightDamage)
				print("I'm attacking " + enemy.name)


func _on_body_entered(body: Node2D) -> void:
	if (body.is_in_group("enemies")):
		targetedEnemies.append(body)


func _on_body_exited(body: Node2D) -> void:
	if (targetedEnemies.has(body)):
		targetedEnemies.erase(body)
		print(body.name, " left my watch")
