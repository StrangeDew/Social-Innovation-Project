extends Node

@onready var canvasItem : CanvasItem = $"."
@export var openButtons : Array[Button]
@export var closeButtons : Array[Button]

@export var childButtons : Array[Button]

@export var isOpen : bool = true
@export var lerpValue : float = 1.0
var speedScaler : float = 1.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if openButtons.size() > 0:
		for button in openButtons:
			button.pressed.connect(OpenMenu)
		
	if closeButtons.size() > 0:
		for button in closeButtons:
			button.pressed.connect(CloseMenu)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if isOpen:
		if lerpValue < 1.0:
			lerpValue += delta * speedScaler
	else:
		if lerpValue > 0.0:
			lerpValue -= delta * speedScaler
	
	if lerpValue > 1.0:
		lerpValue = 1.0
	
	if lerpValue < 0.0:
		lerpValue = 0.0
		canvasItem.visible = false
	
	canvasItem.modulate.a = lerpValue
	


func CloseMenu():
	isOpen = false
	for child in childButtons:
		child.disabled = true


func OpenMenu():
	isOpen = true
	canvasItem.visible = true
	for child in childButtons:
		child.disabled = false
