extends Sprite2D

@export var textures : Array[Texture]

enum StateEnum { Delay, FadeIn, Idle }
@export var currState : StateEnum = StateEnum.Idle

@export var delayTimer : float = 0.0
@export var delayTime : float = 1.0

@export var lerpValue : float = 1.0
@export var lerpSpeed : float = 2.0

@export var newIndex : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (currState == StateEnum.Delay):
		if (delayTimer < delayTime):
			delayTimer += delta
		else:
			currState = StateEnum.FadeIn
			texture = textures[newIndex]
			lerpValue = 0.0
	
	if (currState == StateEnum.FadeIn):
		if (lerpValue < 1.0):
			lerpValue += delta * lerpSpeed
		else:
			lerpValue = 1.0
			currState = StateEnum.Idle
	
	modulate.a = lerpValue
	


func change_sprite(index : int) -> void:
	currState = StateEnum.Delay
	delayTimer = 0.0
	lerpValue = 1.0
	newIndex = index
