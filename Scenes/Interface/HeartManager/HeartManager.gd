extends CanvasLayer

onready var Player = get_node("../../Player")

const HEART_ROW_SIZE = 8
const HEART_OFFSET = 14

func _ready():
	for i in Player.HealthNode.max_health:
		var new_heart = AnimatedSprite.new()
		new_heart.frames = $Hearts.frames
		new_heart.playing = true
		$Hearts.add_child(new_heart)

# warning-ignore:unused_argument
func _process(delta):
	for heart in $Hearts.get_children():
		var index = heart.get_index()
		var x = (index % HEART_ROW_SIZE) * HEART_OFFSET
		var y = (index / HEART_ROW_SIZE) * HEART_OFFSET

		heart.position = Vector2(x, y)


		var last_heart = Player.HealthNode.health
		if index >= last_heart:
			heart.animation = "Empty"
		if index < last_heart and (index + 1) > last_heart:
			heart.animation = "Half"
		elif index < last_heart:
			heart.animation = "Full"
