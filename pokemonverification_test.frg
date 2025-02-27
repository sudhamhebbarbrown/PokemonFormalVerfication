#lang forge/froglet

open "pokemonverification.frg"

test suite for wellformedPokemonType {
    example validSetup is {wellformedPokemonType} for {
        PokemonType = `FireType + `WaterType + `GrassType
    }
    
    example typeValid is {wellformedPokemonType} for {
        PokemonType = `WaterType
    }
}

test suite for wellformedPokemonMove {
    // test suite for valid m oves, (2 moves and power)
    example validMoves is {wellformedPokemonMove} for {
        PokemonMove = `Tackle + `Ember
        PokemonType = `NormalType + `FireType
        moveType = `Tackle -> `NormalType + `Ember -> `FireType
        power = `Tackle -> 1 + `Ember -> 2
    }
    
    // test power level, power level shouldn't be above the bounds set
    example powerTooHigh is {not wellformedPokemonMove} for {
        PokemonMove = `HyperBeam
        PokemonType = `NormalType
        moveType = `HyperBeam -> `NormalType
        power = `HyperBeam -> 5 // 1-3
    }
    
    // power too low
    example powerTooLow is {not wellformedPokemonMove} for {
        PokemonMove = `Splash
        PokemonType = `WaterType
        moveType = `Splash -> `WaterType
        power = `Splash -> 0 
    }
    
}

// test to see if pokemon satisfies the limitations we've set
test suite for wellformedpokemon {
    example validPokemon is {wellformedpokemon[`Pikachu]} for {
        Pokemon = `Pikachu
        TURN = `Turn1
        hp = `Pikachu -> (`Turn1 -> 7)
        moves = `Pikachu -> (0 -> `Move1 + 1 -> `Move2)
        PokemonMove = `Move1 + `Move2
    }
    
    // fails because too many moves
    example tooManyMoves is {not wellformedpokemon[`Squirtle]} for {
        Pokemon = `Squirtle
        TURN = `Turn1
        hp = `Squirtle -> (`Turn1 -> 7)
        moves = `Squirtle -> (0 -> `Move1 + 1 -> `Move2 + 2 -> `Move3)
        PokemonMove = `Move1 + `Move2 + `Move3
    }
    
    // tests to see if the fainting effect of no hp works as intended
    example faintHP is {not wellformedpokemon[`Charmander]} for {
        Pokemon = `Charmander
        TURN = `Turn1
        hp = `Charmander -> (`Turn1 -> -1)
    }
}
