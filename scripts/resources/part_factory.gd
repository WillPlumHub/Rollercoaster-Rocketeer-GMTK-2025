@tool
class_name PartFactory extends Node

static var _parts: Array[PartInfo] = [
	PartInfo.new(
		"Loop",
		null,
		[
			PropertyModifier.new(
				PropertyModifier.CompoundingType.ADDITIVE_FLAT,
				PropertyModifier.AffectedProperty.SPEED,
				1.0
			)
		]
	)
]
