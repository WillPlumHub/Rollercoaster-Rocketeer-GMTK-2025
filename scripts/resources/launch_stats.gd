@tool
## All possible data for launch (will be modified by PartInfo) in the line
class_name LaunchStats extends Resource

## IMPORTANT NOTE: WHEN PROPERTY LIST IS UPDATED UPDATE THE FOLLOWING:
## enum AffectedProperty 
## affected_property_data_lookup and 
## add, multiply and _init functions

@export var speed: float = 0.0
@export var fun: float = 0.0
@export var gold: float = 0.0
@export var package_count: float = 0.0
@export var passenger_count: float = 0.0
@export var thruster_power: float = 0.0
@export var thruster_fuel: float = 0.0
@export var armor: float = 0.0
@export var normal_gun: float = 0.0
@export var through_gun: float = 0.0

enum AffectedProperty {
	SPEED = 0,
	FUN,
	GOLD,
	PACKAGE_COUNT,
	PASSENGER_COUNT,
	THRUSTER_POWER,
	THRUSTER_FUEL,
	ARMOR,
	NORMAL_GUN,
	THROUGH_GUN
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
	AffectedProperty.PASSENGER_COUNT: PropertyData.new("passengers", Color.SKY_BLUE, "passenger_count"),
	AffectedProperty.THRUSTER_POWER: PropertyData.new("Thruster Power", Color.SKY_BLUE, "thruster_power"),
	AffectedProperty.THRUSTER_FUEL: PropertyData.new("Fuel", Color.SKY_BLUE, "thruster_fuel"),
	AffectedProperty.ARMOR: PropertyData.new("Armor", Color.SKY_BLUE, "armor"),
	AffectedProperty.NORMAL_GUN: PropertyData.new("Gun", Color.SKY_BLUE, "normal_gun"),
	AffectedProperty.THROUGH_GUN: PropertyData.new("Electro Orb", Color.SKY_BLUE, "through_gun")
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
	thruster_power += other.thruster_power
	thruster_fuel += other.thruster_fuel
	armor += other.armor
	normal_gun += other.normal_gun
	through_gun += other.through_gun

func multiply(other: LaunchStats):
	if other == null:
		return
	speed *= other.speed
	fun *= other.fun
	gold *= other.gold
	package_count *= other.package_count
	passenger_count *= other.passenger_count
	thruster_power *= other.thruster_power
	thruster_fuel *= other.thruster_fuel
	armor *= other.armor
	normal_gun *= other.normal_gun
	through_gun *= other.through_gun

func _init(
	p_speed: float = 0.0,
	p_fun: float = 0.0,
	p_gold: float = 0.0,
	p_package_count: float = 0.0,
	p_passenger_count: float = 0.0,
	p_thruster_power: float = 0.0,
	p_thruster_fuel: float = 0.0,
	p_armor: float = 0.0,
	p_normal_gun: float = 0.0,
	p_through_gun: float = 0.0
):
	speed = p_speed
	fun = p_fun
	gold = p_gold
	package_count = p_package_count
	passenger_count = p_passenger_count
	thruster_power = p_thruster_power
	thruster_fuel = p_thruster_fuel
	armor = p_armor
	normal_gun = p_normal_gun
	through_gun = p_through_gun



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
