extends Control

var canSkip : bool = false
@onready var skipLabel: Label = $Label

func _on_video_stream_player_finished() -> void:
	start_game()
	pass

func _input(event: InputEvent) -> void:
	if(canSkip and event.is_action_pressed("skip_prologue")):
		start_game()
		
func start_game():
	get_tree().change_scene_to_file("res://Scenes/gameScenes/game_scene.tscn")
	pass


func _on_skip_timer_message_timeout() -> void:
	canSkip = true
	skipLabel.visible = true
	pass # Replace with function body.
