@tool
class_name PropertyModifier extends Resource

enum CompoundingType {
	ADDITIVE_FLAT,
	ADDITIVE_PERCENTAGE,
	MULTIPLICATIVE,
}

enum AffectedProperty {
	SPEED,
	FUN,
	GOLD,
	PACKAGE_COUNT,
	PASSENGER_COUNT
}
static var affected_property_data_lookup: Dictionary[AffectedProperty, PropertyData] = {
	AffectedProperty.SPEED: PropertyData.new("speed", Color.GREEN, "speed"),
	AffectedProperty.FUN: PropertyData.new("fun", Color.DARK_ORCHID, "fun"),
	AffectedProperty.GOLD: PropertyData.new("gold", Color.GOLD, "gold"),
	AffectedProperty.PACKAGE_COUNT: PropertyData.new("packages", Color.BROWN, "package_count"),
	AffectedProperty.PASSENGER_COUNT: PropertyData.new("passengers", Color.SKY_BLUE, "passenger_count")
}

@export var compounding_type: CompoundingType = CompoundingType.ADDITIVE_FLAT:
	get:
		return compounding_type
	set(new_compounding_type):
		compounding_type = new_compounding_type
		emit_changed()

@export var affected_property: AffectedProperty = AffectedProperty.SPEED:
	get:
		return affected_property
	set(new_affected_property):
		affected_property = new_affected_property
		emit_changed()
		
@export var amount: float = 0.0:
	get:
		return amount
	set(new_amount):
		amount = new_amount
		emit_changed()

func _init(
	p_compounding_type: CompoundingType = CompoundingType.ADDITIVE_FLAT,
	p_affected_property: AffectedProperty = AffectedProperty.SPEED,
	p_amount: float = 0.0
):
	compounding_type = p_compounding_type
	affected_property = p_affected_property
	amount = p_amount


## This is used to quickly grab display text/color/path
class PropertyData extends Resource:
	var display_text: String = ""
	var display_color: Color = Color.WHITE
	var property_path: String = ""
	
	func _init(
		p_display_text: String = "",
		p_display_color: Color = Color.WHITE,
		p_property_path: String = ""
	):
		display_text = p_display_text
		display_color = p_display_color
		property_path = p_property_path
