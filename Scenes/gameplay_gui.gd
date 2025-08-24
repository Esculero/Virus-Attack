extends Control

var MAX_SIZE: float
var alveoli_count := 0

@onready var health_bar: ColorRect = $HealthBar
@onready var counter: Label = $HBoxContainer/Counter

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	MAX_SIZE = health_bar.size.x


func update_health_bar(percentage: float) -> void:
	health_bar.size.x += percentage * MAX_SIZE

func update_alveoli_count(count: int) -> void:
	alveoli_count += count
	
	counter.text = " x " + str(alveoli_count) + " left!"
