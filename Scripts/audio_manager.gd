extends AudioStreamPlayer

func play_audio(stream_to_play: AudioStream):
	stream = stream_to_play
	play()

func play_audio_random_pitch(stream_to_play: AudioStream, scale_min: float, scale_max: float):
	pitch_scale = randf_range(scale_min, scale_max) 
	play_audio(stream_to_play)
	await finished
	pitch_scale = 1.0
