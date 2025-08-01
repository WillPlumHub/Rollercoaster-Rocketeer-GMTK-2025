@tool
## All possible data for launch (will be modified by PartInfo) in the line
class_name LaunchStats extends Resource

## IMPORTANT NOTE: WHEN PROPERTY LIST IS UPDATED UPDATE THE FOLLOWING:
## enum AffectedProperty 
## affected_property_data_lookup and 

@export var speed: float = 0.0
@export var fun: float = 0.0
@export var gold: float = 0.0
@export var package_count: float = 0.0
@export var passenger_count: float = 0.0

enum AffectedProperty {
	SPEED = 0,
	FUN,
	GOLD,
	PACKAGE_COUNT,
	PASSENGER_COUNT
}
static var affected_property_data_lookup: Dictionary[AffectedProperty, PropertyData] = {
	AffectedProperty.SPEED: PropertyData.new(
		"speed", # display text
		Color.GREEN, # display color
		"speed" # property path
	),
	AffectedProperty.FUN: PropertyData.new("fun", Color.DARK_ORCHID, "fun"),
	AffectedProperty.GOLD: PropertyData.new("gold", Color.GOLD, "gold"),
	AffectedProperty.PACKAGE_COUNT: PropertyData.new("packages", Color.BROWN, "package_count"),
	AffectedProperty.PASSENGER_COUNT: PropertyData.new("passengers", Color.SKY_BLUE, "passenger_count")
}

func add_property_modifier(mod: PropertyModifier):
	var property_path = affected_property_data_lookup[mod.affected_property].property_path
	var current: float = get(property_path)
	set(property_path, current + mod.amount)

func add(other: LaunchStats):
	if other == null:
		return
	speed += other.speed
	fun += other.fun
	gold += other.gold
	package_count += other.package_count
	passenger_count += other.passenger_count

func multiply(other: LaunchStats):
	if other == null:
		return
	speed *= other.speed
	fun *= other.fun
	gold *= other.gold
	package_count *= other.package_count
	passenger_count *= other.passenger_count

func _init(
	p_speed: float = 0.0,
	p_fun: float = 0.0,
	p_gold: float = 0.0,
	p_package_count: float = 0.0,
	p_passenger_count: float = 0.0
):
	speed = p_speed
	fun = p_fun
	gold = p_gold
	package_count = p_package_count
	passenger_count = p_passenger_count


## This is used to quickly grab display text/color/path
class PropertyData extends Resource:
	## display_text is what we can use to display to the user the property name
	var display_text: String = ""
	## display_color is what we can use to highlight the property name text
	var display_color: Color = Color.WHITE
	## property_path is the reference to the property name in the object
	var property_path: String = ""
	
	func _init(
		p_display_text: String = "",
		p_display_color: Color = Color.WHITE,
		p_property_path: String = ""
	):
		display_text = p_display_text
		display_color = p_display_color
		property_path = p_property_path
