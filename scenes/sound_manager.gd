extends Node

# EXAMPLE USE:
# SoundManager.play_sound("example", 1, 0)

func play_sound(sound, pitch, vol):
	var soundplayer = find_child(sound)
	if soundplayer == null:
		printerr('SoundManager Error: Couldnt Find Sound')
	else:
		soundplayer.pitch_scale = pitch
		soundplayer.volume_db = vol
		soundplayer.play()
		soundplayer.pitch_scale = 1
