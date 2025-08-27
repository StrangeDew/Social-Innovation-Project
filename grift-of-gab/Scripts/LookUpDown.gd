extends Node

@export var parent : Node2D
@export var isLookingUp : bool = false

var lerpValue : float = 0.0
var upValue : float = 0.0
var downValue : float = -612.0

var accel : float = 0.0
var accelScale : float = 0.1

var delayTimer : float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (delayTimer > 0.0):
		delayTimer -= delta
		
		if (delayTimer < 0.0):
			delayTimer = 0.0
	
	if (delayTimer == 0.0):
		if (isLookingUp && lerpValue < 1.0):
			accel -= delta * accelScale
			lerpValue += accel
			
			if (lerpValue > 1.0):
				lerpValue = 1.0
		
		if (!isLookingUp && lerpValue > 0.0):
			accel -= delta * accelScale
			lerpValue -= accel
			
			if (lerpValue < 0.0):
				lerpValue = 0.0
		
		parent.position.y = lerpf(downValue, upValue, lerpValue)
	pass

func SetLook(isUp: bool):
	isLookingUp = isUp
	accel = 0.06
	pass

func ToggleLook():
	isLookingUp = !isLookingUp
	accel = 0.06
	pass

func DelayToggleLook(delay: float):
	delayTimer = delay
	isLookingUp = !isLookingUp
	accel = 0.06
	pass
