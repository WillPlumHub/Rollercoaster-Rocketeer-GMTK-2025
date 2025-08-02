extends Resource
class_name CutsceneFrames

var frame_index:int = 0
@export var frames: Array[CompressedTexture2D]

func get_next_frame():
	frame_index+=1
	if frame_index > frames.size()-1:
		return null
	else:
		return frames[frame_index]
