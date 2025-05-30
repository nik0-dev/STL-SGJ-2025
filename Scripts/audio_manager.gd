extends Node

var active_channels: Array[AudioStreamPlayer] = [] 
var inactive_channels: Array[AudioStreamPlayer] = []

var music_channel: AudioStreamPlayer 

const POOLED_AUDIO_CHANNELS : int = 16

func _ready() -> void:
	for i in range(0, POOLED_AUDIO_CHANNELS):
		var asp = instance_audio_channel()
		inactive_channels.append(asp)
		asp.finished.connect(swap_to_inactive.bind(asp))
	music_channel = instance_audio_channel()

func instance_audio_channel() -> AudioStreamPlayer:
	var asp = AudioStreamPlayer.new()
	var count : int = inactive_channels.size() + active_channels.size()
	asp.name = "AudioStreamChannel" + str(count)
	add_child(asp) 
	return asp

func swap_to_inactive(player: AudioStreamPlayer):
	if active_channels.has(player):
		active_channels.erase(player)
		inactive_channels.append(player)

func swap_to_active(player: AudioStreamPlayer):
	if inactive_channels.has(player):
		inactive_channels.erase(player)
		active_channels.append(player)
		
func play_audio_impl(player: AudioStreamPlayer, stream: AudioStream):
	if player != null && !player.playing:
		player.stream = stream
		swap_to_active(player)
		player.play()
	
func play_audio(stream: AudioStream):
	play_audio_impl(get_free_channel(), stream)

func play_audio_random_pitch(stream: AudioStream, min_v: float, max_v: float):
	var free_channel = get_free_channel()
	if free_channel != null:
		free_channel.pitch_scale = randf_range(min_v, max_v)
		play_audio_impl(free_channel, stream)
		await free_channel.finished
		free_channel.pitch_scale = 1.0

func get_free_channel() -> AudioStreamPlayer:
	if inactive_channels.size() > 0:
		return inactive_channels[0]
	return null
