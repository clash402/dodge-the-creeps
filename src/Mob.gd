extends RigidBody2D

# PROPERTIES
export var min_speed = 150
export var max_speed = 250

onready var anim_sprite = $AnimatedSprite


# DEFAULTS
func _ready():
	pick_random_mob()


# SIGNALS
func _on_screen_exited():
	queue_free()


# CUSTOM
func pick_random_mob():
	randomize()
	var mob_types = anim_sprite.frames.get_animation_names()
	anim_sprite.animation = mob_types[randi() % mob_types.size()]
