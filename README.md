Hello fellow Developers!!

## What is MovementHandler?

Today I am releasing my first open-source module, the MovementHandler!! Making things like Crouch, Sprint, Slide, PRone can be easy but kind of boring at the same time(because it's easy). It is used very frequently in a lot of games. I am working on a FPS Framework as well, and I hadn't really planned to make this, but my ego ate me up and I couldn't bear watching games having these abilities but my framework not. So I took some time and made this. It is very very easy to use, and if you have some quality animations, you could get quite a lot out of this. 

## How to use it?

### Basic Example:

```lua
local MovementProfile = require(game.ReplicatedStorage.MovementHandler.MovementHandler)

MovementProfile = MovementProfile:New({Player = game.Players.GiantDefender427})
MovementProfile:Initiate()
```

To use the animations provided in the Script itself, you will have to upload the animations to your account and then replace the `AnimationIds` in the `Animation` objects accordingly.

The script automatically adjusts if the character dies and respawns.

Abilities can be enabled and disabled, plus the whole profile itself.

## Keybinds
- Sprint - `LeftShift`
- Crouch - `C`
- Slide - `C`
- Prone - `C`

## License 
### Mozilla Public License 2.0
Permissions of this weak copyleft license are conditioned on making available source code of licensed files and modifications of those files under the same license (or in certain cases, one of the GNU licenses). Copyright and license notices must be preserved. Contributors provide an express grant of patent rights. However, a larger work using the licensed work may be distributed under different terms and without source code for files added in the larger work.

Read the full document [here](https://github.com/Giant427/MovementHandler/blob/main/LICENSE).

## Download

Get it [here](https://www.roblox.com/library/7933550317/MovementHandler)
or from the [GitHub Repository](https://github.com/Giant427/MovementHandler)

P.s. this is my first time making something open-source please go easy on me and drop your feedback!!
