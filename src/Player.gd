extends Area2D

# PROPERTIES
signal hit

export var speed = 400

onready var anim_sprite = $AnimatedSprite
onready var collision_shape = $CollisionShape2D
onready var screen_size = get_viewport_rect().size
#onready var player_size = anim_sprite.frames.get_frame("up", 0).get_size()

var velocity = Vector2.ZERO


# DEFAULTS
func _ready():
	hide()


func _process(delta):
	move()
	set_position(delta)
	animate()


# SIGNALS
func _on_body_entered(body):
	hide()
	collision_shape.set_deferred("disabled", true)
	emit_signal("hit")


# CUSTOM
func move():
	velocity = Vector2.ZERO
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed


func set_position(delta):
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)


func animate():
	if velocity.length() > 0:
		anim_sprite.play()
	else:
		anim_sprite.stop()
	if velocity.x != 0:
		anim_sprite.animation = "walk"
		anim_sprite.flip_v = false
		anim_sprite.flip_h = velocity.x < 0
	elif velocity.y != 0:
		anim_sprite.animation = "up"
		anim_sprite.flip_v = velocity.y > 0


func reset(pos):
	position = pos
	collision_shape.disabled = false
	show()
