class_name PlayerInfo extends Node

# TODO: we could save resource and preload instead.
var BASE_STATS: LaunchStats = LaunchStats.new(
	1.0, # speed
	1.0, # fun
	1.0, # gold
	1.0, # package_count
	1.0, # passenger_count
)
var engine_cart: PartInfo = EngineCartFactory.STARTING_ENGINE_CART.duplicate(true)

var owned_tracks: Array[PartInfo] = []
var placed_tracks: Array[PartInfo] = []

var owned_carts: Array[PartInfo] = []
var linked_carts: Array[PartInfo] = []

func calculate_final_launch_stats() -> LaunchStats:
	var new_launch_stats: LaunchStats = BASE_STATS.duplicate(true)
	var additive_percentage_launch_stats: LaunchStats = LaunchStats.new()
	var multiplicative_launch_stats: LaunchStats = LaunchStats.new()
	for placed_track in placed_tracks:
		for track_modifier in placed_track.modifiers:
			match track_modifier.CompoundingType:
				PropertyModifier.CompoundingType.ADDITIVE_FLAT:
					new_launch_stats.add_property_modifier(track_modifier)
				PropertyModifier.CompoundingType.ADDITIVE_PERCENTAGE:
					additive_percentage_launch_stats.add_property_modifier(track_modifier)
				PropertyModifier.CompoundingType.MULTIPLICATIVE:
					multiplicative_launch_stats.add_property_modifier(track_modifier)
	for linked_cart in linked_carts:
		for cart_modifier in linked_cart.modifiers:
			match cart_modifier.CompoundingType:
				PropertyModifier.CompoundingType.ADDITIVE_FLAT:
					new_launch_stats.add_property_modifier(cart_modifier)
				PropertyModifier.CompoundingType.ADDITIVE_PERCENTAGE:
					additive_percentage_launch_stats.add_property_modifier(cart_modifier)
				PropertyModifier.CompoundingType.MULTIPLICATIVE:
					multiplicative_launch_stats.add_property_modifier(cart_modifier)
	new_launch_stats.multiply(additive_percentage_launch_stats)
	new_launch_stats.multiply(multiplicative_launch_stats)
	return new_launch_stats
