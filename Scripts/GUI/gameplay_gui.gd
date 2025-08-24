extends Control

var MAX_SIZE: float
var alveoli_count := 0

@onready var health_bar: ColorRect = $HealthBar
@onready var counter: Label = $HBoxContainer/Counter

@onready var game_paused: Control = $GamePaused
@onready var win_screen: Control = $WinScreen
@onready var lose_screen: Control = $LoseScreen


var isPaused : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	MAX_SIZE = health_bar.size.x

func update_health_bar(percentage: float) -> void:
	health_bar.size.x += percentage * MAX_SIZE

func update_alveoli_count(count: int) -> void:
	alveoli_count += count
	
	counter.text = " x " + str(alveoli_count) + " left!"
	
	if(alveoli_count == 0):
		ToggleWin()

func _input(event: InputEvent) -> void:
	if(event.is_action_pressed("escape")):
		if(isPaused):
			UnpauseGame()
		else:
			PauseGame()
			pass

func _on_resume_bt_pressed() -> void:
	UnpauseGame()

func _on_quit_bt_pressed() -> void:
	Engine.time_scale = 1.0
	get_tree().change_scene_to_file("res://Scenes/gameScenes/main_menu.tscn")

func ToggleWin():
	Engine.time_scale = 0.0
	win_screen.visible = true
	pass
	
func ToggleLose():
	Engine.time_scale = 0.0
	lose_screen.visible = true
	pass
	
func PauseGame():
	game_paused.visible = true
	Engine.time_scale = 0.0

func UnpauseGame():
	game_paused.visible = false
	Engine.time_scale = 1.0

func _on_retry_bt_pressed() -> void:
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()
