extends CharacterBody2D

const SPEED = 500.0
const JUMP_VELOCITY = -2000.0
var current_jump_velocity = JUMP_VELOCITY

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	var horizontal_input = (
		
		Input.get_action_strength("Left")
		- Input.get_action_strength("Right")
	)

	var grounded = false

	for i in get_node('GroundedCollider').get_overlapping_bodies():
		if i.has_meta('TotemType'):
			if i.get_meta('TotemType') == 'Turtle':
				continue

		grounded = true

	var vertical_input = 0

	if grounded:
		vertical_input = Input.get_action_strength("Jump")

	velocity.x = horizontal_input * SPEED

	velocity.y += vertical_input * current_jump_velocity 
	velocity.y += gravity

	move_and_slide()


func _on_frog_ability_collider_area_entered(area):
	current_jump_velocity = -2500
	pass # Replace with function body.


func _on_frog_ability_collider_area_exited(area):
	current_jump_velocity = JUMP_VELOCITY
	pass # Replace with function body.
