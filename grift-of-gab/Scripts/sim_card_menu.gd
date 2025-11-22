extends ColorRect

@export var simCard : Node
@export var goal : float = 936.0
@export var errorMargin : float = 25.0
@export var currValue : float = 0.0
@export var top : float = 1066.0
@export var bottom : float = 806.0
@export var isMoveUp : bool = false
@export var isFired : bool = false
@export var speed : float = 500.0
var delayTimer : float = 0.0
var delayTime : float = 1.0
var right : float = 926.0
var left : float = 226.0
var leftMiss : float = 565.0
var closeTimer : float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if delayTimer < delayTime:
		if  (get_parent() as Node2D).visible:
			delayTimer += delta
	else:
		if Input.is_action_just_pressed("click"):
				isFired = true
	
	if isFired:
		if abs(simCard.position.y - goal) <= errorMargin:
			if simCard.position.x > left:
				simCard.position.x -= delta * speed * 2.0
			else:
				if closeTimer < delayTime:
					closeTimer += delta
				else:
					get_parent().CloseMenu()
					get_node("%Hand").selectorEnabled = true
		else:
			if simCard.position.x > leftMiss:
				simCard.position.x -= delta * speed * 2.0
			else:
				if closeTimer < delayTime:
					closeTimer += delta
				else:
					get_parent().CloseMenu()
					get_node("%Hand").selectorEnabled = true
		return
	
	if isMoveUp:
		if currValue < top:
			currValue += delta * speed
	else:
		if currValue > bottom:
			currValue -= delta * speed
	
	if currValue < bottom or currValue > top:
		isMoveUp = !isMoveUp
		clampf(currValue, bottom, top)
	
	simCard.position.y = currValue


func _on_sim_card_menu_visibility_changed() -> void:
	currValue = lerpf(bottom, top, randf())
	delayTimer = 0.0
	isFired = false
	simCard.position.x = right
