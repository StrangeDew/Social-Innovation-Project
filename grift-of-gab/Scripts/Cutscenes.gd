extends Node

enum StateEnum { LookUp, FadeIn, PrintText, AwaitInput, FadeOut, LookDown }
var currState : StateEnum = 0

var currGameState : int = 0

@export var table : Node2D
@export var lookUpDown : Node
@export var label : Label
@export var textBox : CanvasItem
@export var items1 : Node2D
@export var items2 : Node2D

@export var alphaValue : float = 0.0
@export var fadeSpeed : float = 4.0

@export var index : int = 0

@export var setDialogue : Array[String]
@export_multiline var startDialogue : Array[String]
@export_multiline var loseDialogue : Array[String]

@export var charIndex : int = -1
@export var charTimer : float = 0.0
@export var charSpeed : float = 40.0
@export var displayString : String = ""

@export var delayTimer : float = 0.0
@export var delayTime : float = 0.25

signal cutscene_ended

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (currState == StateEnum.LookUp):
		if (lookUpDown.lerpValue >= 1.0):
			currState = StateEnum.FadeIn
	
	if (currState == StateEnum.FadeIn):
		if (alphaValue < 1.0):
			alphaValue += delta * fadeSpeed
		else:
			alphaValue = 1.0
			currState = StateEnum.PrintText
	
	if (currState == StateEnum.PrintText):
		charTimer += delta * charSpeed
		
		if (charTimer > 1.0):
			charTimer = 0.0
			charIndex += 1
			
			# Update displayString
			if (charIndex < setDialogue[index].length()):
				displayString += setDialogue[index][charIndex]
				label.text = displayString
			else:
				currState = StateEnum.AwaitInput
	
	if (currState == StateEnum.AwaitInput):
		if (delayTimer < delayTime):
			delayTimer += delta
		else:
			delayTimer = delayTime
		
		# Reset displayString
		if (Input.is_action_just_pressed("click") && delayTimer >= delayTime):
			index += 1
			charIndex = -1
			delayTimer = 0.0
			
			if (index < setDialogue.size()):
				displayString = ""
				currState = StateEnum.PrintText
			else:
				currState = StateEnum.FadeOut
	
	if (currState == StateEnum.FadeOut):
		if (alphaValue > 0.0):
			alphaValue -= delta * fadeSpeed
		else:
			alphaValue = 0.0
			lookUpDown.SetLook(false)
			currState = StateEnum.LookDown
			table.change_sprite(1)
			items1.CloseMenu()
			items2.OpenMenu()
			
			if (currGameState == 0):
				cutscene_ended.emit()
	
	textBox.modulate.a = alphaValue
	


func _on_button_pressed() -> void:
	play_cutscene(0)

func play_cutscene(gameState : int):
	if (gameState == 0):
		setDialogue = startDialogue
	
	if (gameState == 1):
		setDialogue = loseDialogue
	
	reset_variables()
	currGameState = gameState

func reset_variables():
	alphaValue = 0.0
	fadeSpeed = 4.0
	index = 0
	charIndex = -1
	charTimer = 0.0
	charSpeed = 40.0
	displayString = ""
	delayTimer = 0.0
	delayTime = 0.25
