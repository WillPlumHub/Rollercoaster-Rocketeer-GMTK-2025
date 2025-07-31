@tool
class_name PropertyModifier extends Resource

enum CompoundingType {
	ADDITIVE_FLAT,
	ADDITIVE_PERCENTAGE,
	MULTIPLICATIVE,
}

@export var compounding_type: CompoundingType = CompoundingType.ADDITIVE_FLAT:
	get:
		return compounding_type
	set(new_compounding_type):
		compounding_type = new_compounding_type
		emit_changed()

@export var affected_property: LaunchStats.AffectedProperty = LaunchStats.AffectedProperty.SPEED:
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
	p_affected_property: LaunchStats.AffectedProperty = LaunchStats.AffectedProperty.SPEED,
	p_amount: float = 1.0,
	p_compounding_type: CompoundingType = CompoundingType.ADDITIVE_FLAT,
):
	compounding_type = p_compounding_type
	affected_property = p_affected_property
	amount = p_amount
