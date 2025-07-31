## class_name RarityRandomizer
extends Node

const BASE_COMMON_FIND_CHANCE: float = 93.9
const BASE_UNCOMMON_FIND_CHANCE: float = 5
const BASE_RARE_FIND_CHANCE: int = 1
const BASE_LEGENDARY_FIND_CHANCE: int = 0.1

enum Rarity {
	COMMON = 0,
	UNCOMMON = 1,
	RARE = 2,
	LEGENDARY = 3
}

## returns 0-3 to match enum Rarity above
func get_random_rarity(
	common_find_mod: float,
	uncommon_find_mod: float,
	rare_find_mod: float,
	legendary_find_mod: float
) -> Rarity:
	return GlobalRng.rng.rand_weighted([
		BASE_COMMON_FIND_CHANCE + common_find_mod,
		BASE_UNCOMMON_FIND_CHANCE + uncommon_find_mod,
		BASE_RARE_FIND_CHANCE + rare_find_mod,
		BASE_LEGENDARY_FIND_CHANCE + legendary_find_mod
	]) 
