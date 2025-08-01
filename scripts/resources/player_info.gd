@tool
class_name PlayerInfo extends Resource

## The base stats that calculate_final_launch_stats will start from
## possible to have different starting stats for different characters
@export var base_stats: LaunchStats = null

## The most recent calculated launch stats
@export var current_stats: LaunchStats = null

## The main front cart for the coaster
@export var engine_cart: PartInfo = null

## The tracks you currently own and can choose from
@export var owned_tracks: Array[PartInfo] = []
## The tracks you have currently placed (should be a subset of owned tracks)
@export var placed_tracks: Array[PartInfo] = []

## The carts you currently own and can choose from
@export var owned_carts: Array[PartInfo] = []
## The carts you have currently linked (should be a subset of owned carts)
@export var linked_carts: Array[PartInfo] = []


func calculate_final_launch_stats() -> LaunchStats:
	var new_launch_stats: LaunchStats = base_stats.duplicate(true) if base_stats != null else LaunchStats.new()
	# set base to 100%
	var additive_percentage_launch_stats: LaunchStats = LaunchStats.new(
		1.0,
		1.0,
		1.0,
		1.0,
		1.0
	)
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
	current_stats = new_launch_stats
	return new_launch_stats

func _init(
	p_base_stats: LaunchStats = null,
	p_engine_cart: PartInfo = null,
	p_owned_tracks: Array[PartInfo] = [],
	p_placed_tracks: Array[PartInfo] = [],
	p_owned_carts: Array[PartInfo] = [],
	p_linked_carts: Array[PartInfo] = []
):
	base_stats = p_base_stats if p_base_stats != null else LaunchStats.new()
	engine_cart = p_engine_cart if p_engine_cart != null else EngineCartFactory.STARTING_ENGINE_CART
	owned_tracks = p_owned_tracks
	placed_tracks = p_placed_tracks
	owned_carts = p_owned_carts
	linked_carts = p_linked_carts
