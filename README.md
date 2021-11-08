Hello fellow Developers!!

## What is MovementHandler?

Today I am releasing my first open-source module, the MovementHandler!! Making things like Crouch, Sprint, Slide can be easy but kind of boring at the same time(because it's easy). It is used very frequently in a lot of games. I am working on a FPS Framework which will be open-source as well, and I hadn't really planned to make this, but my ego ate me up and I couldn't bear watching games having these abilities but my framework not. So I took some time and made this. It is very very easy to use, and if you have some quality animations, you could get quite a lot out of this. 

## How to use it?

This is very simple actually, you run a function in a `LocalScript` or you could say on the `Client`
```lua
:Initiate(Player,SprintSpeed,WalkSpeed)
```

yeah that's it...

```lua
local Player = game.Players.LocalPlayer
local SprintSpeed = 30
local WalkSpeed = 16
local MovementHandler = require(game.ReplicatedStorage:WaitForChild("MovementHandler"))

MovementHandler:Initiate(Player, SprintSpeed, WalkSpeed)
```

Whenever the character is added you have to initiate. As of right now I tried my best to make it dynamic so that it wouldn't break if the character dies and respawns.

Let me break the arguments down a little bit:

- [`Player`](https://developer.roblox.com/en-us/api-reference/class/Player)
The Player, who's character will be affected.

- [`float`](https://developer.roblox.com/en-us/articles/Numbers)  `SprintSpeed`
This will be the `Humanoid.WalkSpeed` during sprinting

- [`float`](https://developer.roblox.com/en-us/articles/Numbers)  `WalkSpeed`
This will be the `Humanoid.WalkSpeed` during walking and crouch walking

## Keybinds
- Sprint - `LeftShift`
- Crouch - `LeftControl` and `C`
- Slide - `LeftControl` and `C`

## Prerequisites 

- `Animation` `CrouchIdle`
- `Animation` `CrouchWalk`
- `Animation` `Slide`

## Download

Get it [here](https://www.roblox.com/library/7933550317/MovementHandler)
or from the [GitHub Repository](https://github.com/Giant427/MovementHandler)

P.s. this is my first time making something open-source please go easy on me and drop your feedback!!
