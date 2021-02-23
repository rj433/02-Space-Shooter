extends KinematicBody2D

var velocity = Vector2.ZERO
var speed = 0.1
var Bullet1 = load("res://Bullets/Bullet1.tscn")
var Bullet2 = load("res://Bullets/Bullet2.tscn")
onready var Bullets = get_node ("/root/Game/Bullets")

func _ready():
	pass 

func _physics_process(_delta):
	velocity += get_input()*speed
	position += velocity
	if position.x >= 1024:
		velocity = Vector2.ZERO
		position.x = 1024
	if position.x <= 0:
		velocity = Vector2.ZERO
		position.x = 0
	if Input.is_action_just_pressed("shoot2"):
		var bullet2 = Bullet2.instance()
		bullet2.position = position + Vector2(0, -30)
		Bullets.add_child(bullet2)

	if Input.is_action_just_pressed("shoot1"):
		$Shoot.wait_time *= 0.95
		print($Shoot.wait_time)

func get_input(): 
	var input_dir = Vector2.ZERO
	if Input.is_action_pressed("left"): 
		input_dir.x -= 1 
	if Input.is_action_pressed("right"): 
		input_dir.x += 1 
	return input_dir.rotated(rotation)

func die(s):
	queue_free()


func _on_Shoot_timeout():
	var bullet1 = Bullet1.instance()
	bullet1.position = position
	Bullets.add_child(bullet1)
	bullet1 = Bullet1.instance()
	bullet1.position = position
	bullet1.velocity.x = 5
	Bullets.add_child(bullet1)
	bullet1 = Bullet1.instance()
	bullet1.position = position
	bullet1.velocity.x = -5
	Bullets.add_child(bullet1)
