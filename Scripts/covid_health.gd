extends Area2D

const HEALTH_POINTS = 20;
@onready var munchStream: AudioStreamPlayer2D = $AudioStreamPlayer2D
const MUNCH = preload("res://Assets/sounds/munch.mp3")
@onready var sprite: Sprite2D = $Sprite2D

func _process(delta: float):
	# move up and down 3 pixels
	position.y += sin(Time.get_ticks_msec() / 200.0) * 10 * delta

func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if(body.has_method("ModifyHealth")):
		body.ModifyHealth(HEALTH_POINTS)
		if(munchStream.playing == false):
			munchStream.stream = MUNCH
			munchStream.play()
			sprite.queue_free()


func _on_audio_stream_player_2d_finished() -> void:
	queue_free()
