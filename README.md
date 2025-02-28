# Pokémon Battle Model

## 1. Project Objective
This project models a **Pokémon battle** system using **Forge/Froglet**. The goal is to represent how Pokémon engage in turn-based combat, considering type-based weaknesses and resistances, move effectiveness, and turn-based interactions. The model simulates attacks, damage calculations, and the progression of battle until one Pokémon is defeated.

## 2. Model Design and Visualization
The model consists of:
- **Pokémon (`Pokemon`)**, each with a type, moveset, and hit points (`hp`).
- **Types (`PokemonType`)** that define weaknesses and resistances (e.g., Water beats Fire).
- **Moves (`PokemonMove`)** with type-based effectiveness and power values.
- **Turn-based combat (`TURN`)**, governed by a battle instance (`BATTLE`) that tracks turns, assigns attackers, and progresses the battle.

### Expected Visualization
- **Nodes**: Represent Pokémon, move types, and battle states.
- **Edges**: Show relationships such as move ownership, Pokémon types, and attack sequences.
- **Battle Progression**: Can be visualized using state transitions between turns (`TURN`).

The model **does not** define a custom visualization, so the default Forge visualizer will be used.

## 3. Signatures and Predicates
### **Signatures**
- **`Pokemon`**: Represents a Pokémon with:
  - `poketype`: Type association (Fire, Water, Grass).
  - `moves`: Move set mapping integers to `PokemonMove`.
  - `hp`: Hit points mapped to each turn.

- **`PokemonType`**: Defines type properties:
  - `type`: The Pokémon’s type (Fire, Water, or Grass).
  - `weakness`: Type that deals double damage.
  - `resistances`: Type that deals half damage.

- **`PokemonMove`**: Represents a move with:
  - `moveType`: The move’s associated type.
  - `power`: The damage value (1-3).

- **`TURN`**: Represents individual turns in the battle.

- **`BATTLE`**: Tracks the battle state:
  - `firstTurn`: The initial turn.
  - `next`: A functional mapping of turns to their successors.
  - `attacker`: Maps each turn to the attacking Pokémon.

### **Predicates**
- **`wellformedpokemon`**: Ensures Pokémon have valid health values and exactly two moves.
- **`wellformedPokemonType`**: Enforces valid type assignments, weaknesses, and resistances.
- **`wellformedPokemonMove`**: Ensures move power is within the valid range (1-3).
- **`init`**: Initializes the battle with valid Pokémon, types, and moves.
- **`attack`**: Computes damage based on type effectiveness:
  - **Double damage** if the move type matches the defender’s weakness.
  - **Half damage** if the move type matches the defender’s resistance.
  - **Normal damage** otherwise.
- **`step`**: Governs turn progression:
  - The attacking Pokémon changes.
  - Moves are executed, and HP is updated accordingly.
  - The turn advances in sequence.
- **`traces`**: Defines the battle process, ensuring proper game flow.
- **`eventuallybattleends`**: Ensures the battle concludes when a Pokémon’s HP reaches 0.

## 4. Testing
The model includes several testable properties:
- **Structural Validations**
  - `wellformedPokemonType`, `wellformedPokemonMove`, and `wellformedpokemon` enforce constraints on the game’s entities.
- **Battle Mechanics**
  - `attack` ensures damage calculation follows Pokémon type rules.
  - `step` confirms turns progress correctly.
- **Termination Condition**
  - `eventuallybattleends` ensures the battle does not run indefinitely.

The **`run` statement** verifies that the battle:
- Progresses logically through turns.
- Enforces type-based damage effects.
- Ends with at least one Pokémon reaching zero HP.

## 5. Documentation
- Each signature and predicate is well-commented in the `.als` file.
- The constraints are designed to match Pokémon battle mechanics, ensuring realistic gameplay simulation.
- The model provides a **turn-based battle sequence** with type effectiveness.

For further exploration, users can modify:
- The number of Pokémon.
- The number of moves.
- The turn sequence length.

**Run the model with:**  
```forge
run {
    traces
    eventuallybattleends
} for exactly 2 Pokemon, exactly 3 PokemonType, 1 BATTLE, 5 TURN for {next is linear}

Results:

Turn 1:
![alt text](image-1.png)

Turn 2:
![alt text](image-2.png)

Turn 3: 
![alt text](image-3.png)

Turn 4:
![alt text](image-4.png)

Turn 5:
![alt text](image-5.png)


