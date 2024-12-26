extends Area2D

var speed = 200
var player = null
var bounce_force = 300
var is_bouncing = false
var bounce_direction = Vector2.ZERO
var bounce_decay = 0.95
var is_exploding = false

onready var explosion_sprite = $AnimatedSprite
onready var sprite = $Sprite
onready var explosion_timer = $Timer

func _ready():
	connect("body_entered", self, "_on_Enemy_body_entered")
	player = get_tree().get_root().get_node("Node2D/Plane")
	
	# Timer'ı ayarla
	explosion_timer.connect("timeout", self, "_on_explosion_finished")
	explosion_timer.one_shot = true

func _process(delta):
	if is_exploding:
		return
		
	if is_bouncing:
		position += bounce_direction * speed * delta
		speed *= bounce_decay
		
		if speed < 50:
			is_bouncing = false
			speed = 200
	elif player:  # Normal takip hareketi
		var direction = (player.position - position).normalized()
		position += direction * speed * delta

func start_explosion():
	is_exploding = true
	is_bouncing = false
	
	if sprite:
		sprite.visible = false
	
	if explosion_sprite:
		explosion_sprite.visible = true
		explosion_sprite.frame = 0
		explosion_sprite.play("explode")
		
		# Timer'ı animasyon süresine göre ayarla
		var animation_length = explosion_sprite.frames.get_frame_count("explode") / 12.0
		explosion_timer.wait_time = animation_length
		explosion_timer.start()

func _on_explosion_finished():
	# Patlama animasyonu bittiğinde düşmanı yok et
	queue_free()

func _on_Enemy_body_entered(body):
	print("Çarpışma algılandı with:", body.name)
	print("Body grupları:", body.get_groups())  # Debug için grupları görelim
	
	# "Player" yerine "player" kullanıyoruz (küçük p ile)
	if body.is_in_group("player"):
		print("Player ile çarpışma!")
		bounce_direction = (position - body.position).normalized()
		is_bouncing = true
		speed = bounce_force
		start_explosion()
	else:
		print("Çarpışma var ama player grubu değil!")
