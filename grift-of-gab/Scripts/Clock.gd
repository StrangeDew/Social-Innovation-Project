extends Sprite2D

@export var textures : Array[Texture]
@export var goalTracker : Node

var isEnabled : bool = false

var delayTimer : float = 0.0
var delayDuration : float = 1.0

var timer : float = 0.0
var duration : float = 128.0 

var currIndex : int = 0

signal time_up

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (!isEnabled):
		return
	
	if (delayTimer < delayDuration):
		delayTimer += delta
	else:
		delayTimer = delayDuration
	
	if (delayTimer == delayDuration):
		if (timer < duration):
			timer += delta
			currIndex = timer * (textures.size() / duration)
		else:
			if (isEnabled):
				timer = duration
				isEnabled = false
				currIndex = 0
				
				if (goalTracker.currMoney < goalTracker.goal):
					time_up.emit()
	
	if (currIndex < textures.size()):
		texture = textures[floori(currIndex)]

func start_timer():
	isEnabled = true
	timer = 0.0
	delayTimer = 0.0


func _on_cutscenes_cutscene_ended() -> void:
	start_timer()
