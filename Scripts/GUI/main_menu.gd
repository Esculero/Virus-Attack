extends Control

@onready var main_menu_container: Control = $MainMenuContainer
@onready var credits_container: Control = $CreditsContainer


func _on_play_bt_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/gameScenes/prologue.tscn")
	pass # Replace with function body.


func _on_credits_bt_pressed() -> void:
	main_menu_container.visible = false
	credits_container.visible = true

func _on_quit_bt_pressed() -> void:
	get_tree().quit()


func _on_return_bt_pressed() -> void:
	main_menu_container.visible = true
	credits_container.visible = false
