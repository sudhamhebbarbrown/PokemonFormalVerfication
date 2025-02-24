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

//Abstract for all types
abstract sig Type {}
one sig Fire, Water, Grass extends Type {}

sig Pokemon {
    // [FILL]
    // name: one String,
    // type: one PokemonType,
    // hp: one Int,
    // moves: set PokemonMove
    type: one PokemonType,
    moves: set PokemonMove,
    hp: one Int
}
sig PokemonType {
    // [FILL]
    // name: one String,
    // weaknesses: set PokemonType,
    // resistances: set PokemonType
    name: one String,
    weaknesses: set PokemonType,
    resistances: set PokemonType


}
sig PokemonMove {
    // [FILL]
    // name: one String,
    // type: one PokemonType,
    // power: one Int
    moveType: one PokemonType,
    power: one Int
}
pred wellformed[p: Pokemon] {
    // [FILL]
    // all pokemon have 100 hp initially
    // all pokemon have at 2 moves
    // all pokemon have a type
    // weakness and resistances are dependent on the type


    all move: PokemonMove | {

        //have the power between 10 and 20
        move.power >=10 and move.power <= 20
    }

    p.hp >= 0 and p.hp <=100
    #{p.moves} = 2

    //2 moves and hp is between 0 and 100.


}

pred wellformedPokemonType {
    // [FILL]
    // We can also hard code the values since we only have 3 types
    // all types have a name
    // all types have a set of weaknesses
    // all types have a set of resistances
    // weaknesses and resistances are disjoint
    #{t: PokemonType | t.name = "Fire"} = 1
    #{t: PokemonType | t.name = "Water"} = 1
    #{t: PokemonType | t.name = "Grass"} = 1
    //hard coding the 3 types

    all t: PokemonType | {
        t.name = "Fire" implies {
            t.weakness = {w: PokemonType | w.name = "Water"}
            t.resistances = {r: PokemonType | r.name = "Grass"}
        }
        t.name = "Water" implies {
            t.weakness = {w: PokemonType | w.name = "Grass"}
            t.resistances = {r: PokemonType | r.name = "Fire"}
        }
        t.name = "Grass" implies {
            t.weaknesses = {w: PokemonType | w.name = "Fire"}
            t.resistances = {r: PokemonType | r.name = "water"}
        }
    }

}

pred wellformedPokemonMove {
    // [FILL]
    // all moves have a name
    // all moves have a type
    // all moves have a power
    m.power >= 10 and m.power <= 20
    one m.moveType
    // not sure what to do about the naming, is that necessary?
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
    move in attacker.moves // attacker goes first

    let baseDamage = move.power | {
        (move.moveType in defender.type.weaknesses) implies {
            defender.hp' = defender.hp - (baseDamage*2) // weakness so double damage

        } else {
            (move.moveType in defender.type.resistance) implies {
                defender.hp' = defender.hp - (baseDamage / 2) // half damage resistance
            } else {
                defender.hp' = defender.hp - baseDamage // normal
            }
        }
    }
    defender.hp' >= 0 // no hp below 0
    defender.type' = defender.type
    defender.moves' = defender.moves
    attacker.hp' = attacker.hp
    attacker.type' = attacker.type
    attacker.moves' = attacker.moves
}

pred pokemonFaint {
    // [FILL]
    // if the hp of a pokemon is less than or equal to 0, the pokemon has fainted
    p.hp <= 0 // do we need this function?
}

assert gameEnds {
    // [FILL]
    // if one pokemon have fainted, the game ends
    all p: Pokemon | {
        pokemonFaint[p] implies {
            no attacker, defender: Pokemon, move: PokemonMove | {
                attack[attacker, defender. move]
            }
        }
    }

}