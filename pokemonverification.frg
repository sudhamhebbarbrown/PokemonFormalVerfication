// TODO
// [SIG] POKEMON
// [SIG] POKEMON TYPE
// [SIG] POKEMON MOVE 
// [PRED] WELLFORMED POKEMON
// [PRED] WELLFORMED POKEMON TYPE
// [PRED] WELLFORMED POKEMON MOVE
// [PRED] ATTACK/MOVE
// [PRED] POKEMON FAINT
// [ASSERT] GAME ENDS

//[IDEA] We could have the same tournament structure. Idk if you've played pokemon games but it'll be similar to elite 4 ig.
#lang forge/froglet

sig Pokemon {
    // [FILL]
    // name: one String,
    // type: one PokemonType,
    // hp: one Int,
    // moves: set PokemonMove
}
sig PokemonType {
    // [FILL]
    // name: one String,
    // weaknesses: set PokemonType,
    // resistances: set PokemonType
}
sig PokemonMove {
    // [FILL]
    // name: one String,
    // type: one PokemonType,
    // power: one Int
}
pred wellformed {
    // [FILL]
    // all pokemon have 100 hp initially
    // all pokemon have at 2 moves
    // all pokemon have a type
    // weakness and resistances are dependent on the type


}

pred wellformedPokemonType {
    // [FILL]
    // We can also hard code the values since we only have 3 types
    // all types have a name
    // all types have a set of weaknesses
    // all types have a set of resistances
    // weaknesses and resistances are disjoint
}

pred wellformedPokemonMove {
    // [FILL]
    // all moves have a name
    // all moves have a type
    // all moves have a power
}

// I will refer to a state transtiion as an attack since we have pokemon move here. Dont want to confuse the two

// Also have to decide which pokemon goes first, we could have a simple speed attribute[INT] to decide this
pred attack [t: Pokemon, p: PokemonMove] {
    // [FILL]
    // damage = power of the move, to keep the game short lets have this in the range of 10-20. With doubling and halving of damage, there should be 5-10 moves to faint a pokemon
    // if the move type is weak against the pokemon type, the damage is doubled
    // if the move type is resistant against the pokemon type, the damage is halved
    // if the move type is the same as the pokemon type, the damage is normal
    // damage calculated should be subtracted from the hp of the pokemon
}

pred pokemonFaint {
    // [FILL]
    // if the hp of a pokemon is less than or equal to 0, the pokemon has fainted
}

assert gameEnds {
    // [FILL]
    // if one pokemon have fainted, the game ends
}