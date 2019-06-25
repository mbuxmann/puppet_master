extends StaticBody2D

export(String, "HoleNormal", "HoleLeft", "HoleMiddle", "HoleRight") var HoleUsed

func _ready():
	match HoleUsed:
		"HoleNormal":
			$AnimationPlayer.play("HoleNormal")
		"HoleLeft":
			$AnimationPlayer.play("HoleLeft")
		"HoleMiddle":
			$AnimationPlayer.play("HoleMiddle")
		"HoleRight":
			$AnimationPlayer.play("HoleRight")
