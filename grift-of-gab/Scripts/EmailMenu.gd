extends TextureRect

var dict = {
	"LonelyGuy@mail.com" : "Hey handsome,\nWire me some cash and we'll meet.\nPrettyLady1",
	"OilTycoon@mail.com" : "Self-made man,\nInvest in Rich Tokens and turn a profit over time without lifting a finger!\nRichy Rich",
	"generous@mail.com" : "Dear kind soul,\nI broke all the bones in my body and need help paying bills.\nFracturedSkeleton",
	"BeautyQueen@mail.com" : "Hey beautiful,\n Looking for a cure to wrinkles?\n Then try our cream for only $999 per bottle!\nRosey Cheeks."
}

@export var contentsLabel : Label
@export var emailLabel : Label

@export var chosenIndices : Array[int]
@export var answerIndex : int = 0
@export var choiceIndex : int = 0

@export var isChoiceSelected : bool = false

var timer : float = 0.0
var time : float = 1.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (isChoiceSelected):
		if (timer < time):
			timer += delta
		
		if (timer > time):
			timer = time
			get_parent().CloseMenu()
			get_node("%Hand").selectorEnabled = true

func set_options():
	chosenIndices.clear()
	
	var indices : Array[int]
	
	for i in range(dict.size()):
		indices.append(i)
	
	for i in range(3):
		var randIndex = randi() % indices.size()
		chosenIndices.append(indices[randIndex])
		indices.remove_at(randIndex)
	
	answerIndex = chosenIndices[randi() % chosenIndices.size()]
	
	emailLabel.text = dict.keys()[choiceIndex]
	contentsLabel.text = dict.values()[answerIndex]


func next_option():
	if (isChoiceSelected):
		return
	
	choiceIndex = (choiceIndex + 1) % 4
	emailLabel.text = dict.keys()[choiceIndex]


func check_correct():
	if (isChoiceSelected):
		return
	
	if (choiceIndex == answerIndex):
		emailLabel.label_settings.font_color = Color.GREEN
		get_node("%Goal Text").add_money((randi() % 10) + 1)
	else:
		emailLabel.label_settings.font_color = Color.RED
	
	isChoiceSelected = true


func _on_choice_texture_button_button_down() -> void:
	next_option()


func _on_send_texture_button_button_down() -> void:
	check_correct()


func _on_email_menu_visibility_changed() -> void:
	emailLabel.label_settings.font_color = Color.BLACK
	isChoiceSelected = false
	timer = 0.0
	set_options()


func _on_cutscenes_cutscene_started() -> void:
	isChoiceSelected = true
