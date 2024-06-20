extends CPUParticles2D

@onready var cpu_particles_2d = $"."

func _ready():
	cpu_particles_2d.emitting = true
