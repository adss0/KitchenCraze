# Kitchen Craze 🍕🍔

**A fast-paced arcade cooking game made in Processing (Java). Drag toppings onto a moving pizza or burger, dodge the falling mould, and survive as each level speeds up. Your best scores are saved to a leaderboard.**

> 🎮 Made with [Processing](https://processing.org/) using object-oriented Java classes for the food, toppings and mould.

---

## Gameplay

1. **Enter your name** and press **Enter**.
2. **Pick your food:** click the pizza or the burger.
   - 🍕 The **pizza** slides across the screen and bounces once at the edge.
   - 🍔 The **burger** moves diagonally across the screen.
3. **Drag toppings** from the top of the screen onto the moving food. Adding the toppings shown in the list at the top right scores **2 points** each.
4. **Dodge the mould.** If falling mould touches the topping you're dragging, you lose a life and the topping goes back to where it started. You have **5 lives**.
5. **Clear the level** by adding every topping on the list. The food then moves **25% faster** in the next level.
6. **Game over** when you run out of lives or the food leaves the screen. Your score is saved to the leaderboard.

---

## Controls

| Input | Action |
|---|---|
| Keyboard + **Enter** | Type your name and start |
| Mouse click | Choose pizza or burger |
| Mouse drag | Move a topping onto the food |
| **C** | Continue to the next level |
| **L** | View the leaderboard (from the game-over screen) |
| **Space** | Play again (from the game-over screen or leaderboard) |

---

## Features

| | Feature |
|---|---|
| 🍕 | Two dishes with different movement: a bouncing pizza and a diagonal burger |
| 🧀 | Six toppings: cheese, onion, mushrooms, tomato, sausage and olives |
| 🦠 | Falling mould obstacles that cost you a life |
| ❤️ | Five lives, shown as hearts |
| ⚡ | Levels that get 25% faster each time |
| 🏆 | High scores saved to `Highscores.txt` and shown on a leaderboard |

---

## Tech stack

| Area | Technology |
|---|---|
| Language | Processing (Java) |
| Graphics | Processing 2D renderer, PNG sprites |
| Storage | Plain text file for high scores |

### Project structure

```
Game/
  Game.pde        ← Main sketch: screens, game loop, input, scoring and lives
  Food.pde        ← Base class for the moving dish
  Pizza.pde       ← Pizza movement (bounces at the edge)
  Burger.pde      ← Burger movement (diagonal)
  Topping.pde     ← Draggable toppings
  Mould.pde       ← Falling mould obstacles
  Highscores.txt  ← Saved scores
  *.png           ← Sprites and backgrounds
```

---

## Getting started

1. Install [Processing](https://processing.org/download) (version 4 recommended).
2. Clone the repository:

   ```bash
   git clone https://github.com/adss0/KitchenCraze.git
   ```

3. In Processing, open **`Game/Game.pde`** and press **Run** ▶️.

---

## License

This project is licensed under the MIT License.
