extends Area2D
signal hit

@export var SPEED = 400
var velocity
var screensize

# Called when the node enters the scene tree for the first time.
func _ready():
	hide() # hiding the player at the beginging of the game
	screensize = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):  #delta is the timestamp of the frame
	# reset velocity
	velocity = Vector2()
	#check which keys have been pressed, ui_[nekineki] preset (project setting -> input map)
	if Input.is_action_pressed("ui_right"):
		velocity.x +=1
	if Input.is_action_pressed("ui_left"):
		velocity.x -=1
	if Input.is_action_pressed("ui_down"):
		velocity.y +=1
	if Input.is_action_pressed("ui_up"):
		velocity.y -=1
	if velocity.length() > 0: # animation when we are moving
		$AnimatedSprite2D.play()
		velocity = velocity.normalized()*SPEED
		$Trail.emitting = true
	else:
		$AnimatedSprite2D.stop()
		$Trail.emitting = false
	
	position += velocity*delta
	
	# constrain the character in the screen
	position.x = clamp(position.x, 0, screensize.x)
	position.y = clamp(position.y, 0, screensize.y)
	
	# Animation handeling
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "right"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0

	if velocity.y != 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = velocity.y > 0  #y e positivo verso il basso
		$AnimatedSprite2D.flip_h = false
	

func _on_body_entered(_body):  #dodala sem underscore
	hide()
	emit_signal("hit")
	call_deferred("set_monitoring", false)
	
func start(pos):  # starting position of the player
	position = pos
	show() #unhide the player
	monitoring = true 
