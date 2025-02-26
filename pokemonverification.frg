#lang forge/froglet

abstract sig Type {}
one sig FIRE, WATER, GRASS extends Type {}

sig Pokemon {
    poketype: one PokemonType,
    moves: pfunc Int -> PokemonMove,
    hp: pfunc TURN -> Int
}
sig PokemonType {
    type: one Type,
    weakness: one Type,
    resistances: one Type
}
sig PokemonMove {
    moveType: one PokemonType,
    power: one Int
}


sig TURN {
}

one sig BATTLE {
    firstTurn: one TURN,
    next: pfunc TURN -> TURN,
    attacker : pfunc TURN -> Pokemon
}

pred wellformedpokemon[p: Pokemon] {
    all t: TURN | {
        p.hp[t] >= 0
    }
    all i: Int | {
        (i<0 or i>=2) implies {
            no p.moves[i]
        }
        (i = 0 or i = 1) implies {
            some p.moves[i]
        }
    }
}

pred wellformedPokemonType {
    all t: PokemonType |
    {
        t.type = FIRE or t.type = WATER or t.type = GRASS
        t.type = FIRE implies {
            t.weakness = WATER
            t.resistances = GRASS
        }
        t.type = WATER implies {
            t.weakness = GRASS
            t.resistances = FIRE
        }
        t.type = GRASS implies {
            t.weakness = FIRE
            t.resistances = WATER
        }
    }
}


pred wellformedPokemonMove {
    all m: PokemonMove |
    {m.power >= 1 and m.power <= 3
    one m.moveType}
}

pred init[t: TURN] {
    // [FILL]
    // all pokemon are wellformed
    // all pokemon types are wellformed
    // all pokemon moves are wellformed
    
    all p: Pokemon | {
        p.hp[t] = 7
        wellformedpokemon[p]}

}

pred attack[att: Pokemon, defender: Pokemon, move: PokemonMove, t1, t2: TURN] {
    // [FILL]
    // if the move type of the move is the weakness of the defender's type, the power of the move is doubled
    // if the move type of the move is the resistance of the defender's type, the power of the move is halved\

    // BATTLE.attacker[t1] = att
    // att != defender
    move.moveType = defender.poketype.weakness implies {
        defender.hp[t2] = subtract[defender.hp[t1], multiply[move.power, 2]]
    }
    move.moveType = defender.poketype.resistances implies {
        defender.hp[t2] = subtract[defender.hp[t1], divide[move.power, 2]]
    }
    move.moveType != defender.poketype.weakness and move.moveType != defender.poketype.resistances implies {
        defender.hp[t2] = subtract[defender.hp[t1], move.power]
    }
}

pred step[t1: TURN, t2: TURN] {
    // [FILL]
    // the next state is the next turn
    BATTLE.attacker[t2] != BATTLE.attacker[t1]
    some t2: TURN | {
        BATTLE.next[t1] = t2
        some BATTLE.attacker[t2]
        some BATTLE.attacker[t1]
    }
    some p: Pokemon | {
        p.hp[t2] = p.hp[t1]
    }
    some att, defender: Pokemon, move: PokemonMove | {
        attack[att, defender, move, t1, t2]
    }
}

pred traces{
    wellformedPokemonType
    wellformedPokemonMove
    init[BATTLE.firstTurn]
    no prev: TURN | BATTLE.next[prev] = BATTLE.firstTurn
    all t: TURN | some BATTLE.next[t] implies {
        step[t, BATTLE.next[t]]
    }

}

pred eventuallybattleends {
    some t: TURN, p:Pokemon | {
        p.hp[t] = 0
    }
}
run {
    traces
    eventuallybattleends
} for exactly 2 Pokemon, exactly 3 PokemonType, 1 BATTLE, 5 TURN for {next is linear}
