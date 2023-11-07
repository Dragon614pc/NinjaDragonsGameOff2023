extends StaticBody2D
var health = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if health <=0:
		queue_free() # remove dummy from scene
		print("dead")
		

func _on_player_sword_hit():
	health -= 1
	print("hit \n{0} hitpoints left".format({"0":health}))
