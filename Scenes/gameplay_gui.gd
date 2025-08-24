extends Control

var MAX_SIZE : float

@onready var health_bar: ColorRect = $HealthBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	MAX_SIZE = health_bar.size.x


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update_health_bar(percentage: float) -> void:
	health_bar.size.x += percentage * MAX_SIZE
