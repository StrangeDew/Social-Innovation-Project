extends Label

@export var currMoney : int = 0
@export var goal : int = 999

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update_text():
	text = "Bills\n$%d / $%d" % [currMoney, goal]

func add_money(amount : int):
	if (amount > 0 || amount < 0 && currMoney >= (-amount)):
		currMoney += amount
	
	update_text()


func _on_cutscenes_cutscene_ended() -> void:
	currMoney = 0
	update_text()
