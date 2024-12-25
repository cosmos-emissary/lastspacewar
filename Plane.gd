extends Node2D

# Uçak gemisinin hızını belirleyen değişken
var speed = 300  # px/saniye

# Hareket yönünü tutacak değişken (veya hız vektörü)
var velocity = Vector2()

# Hareketin yapılacağı hedef nokta
var target_position = Vector2()

# _process fonksiyonu her frame'de çalışacak. Burada hareketi kontrol edeceğiz.
func _process(delta):
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		# Dokunulan nokta hedef olarak belirlenir
		target_position = get_global_mouse_position()
		
		# Hedef pozisyona yönelme (uçak gemisini hedefe doğru hareket ettiriyoruz)
		var direction = (target_position - position).normalized()
		velocity = direction * speed

	# Uçak gemisini hareket ettiriyoruz
	position += velocity * delta

	# Hareketin durdurulması için velocity'nin sıfırlanması
	if not Input.is_mouse_button_pressed(BUTTON_LEFT):
		velocity = Vector2()
