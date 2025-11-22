extends Sprite2D

@export var options : Array[Node2D]
@export var optionSizes : Array[float]
@export var offsets : Array[float]
@export var menus : Array[Node2D]
@export var distance : float
@export var enterDist : float = 5.0

var loopIndex : int = 0

var selectorEnabled : bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (!selectorEnabled):
		return
	
	loopIndex = 0
	
	for option in options:
		distance = option.global_position.distance_to(get_global_mouse_position())
		
		if (distance < enterDist * optionSizes[loopIndex]):
			global_position = option.global_position + Vector2.DOWN * offsets[loopIndex]
			
			if (get_parent().canvasItem.visible && Input.is_action_just_pressed("click")):
				selectorEnabled = false
				menus[loopIndex].OpenMenu()
		
		loopIndex += 1
