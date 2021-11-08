Hello fellow Developers!!

## What is MovementHandler?

Today I am releasing my first open-source module, the MovementHandler!! Making things like Crouch, Sprint, Slide can be easy but kind of boring at the same time(because it's easy). It is used very frequently in a lot of games. I am working on a FPS Framework which will be open-source as well, and I hadn't really planned to make this, but my ego ate me up and I couldn't bear watching games having these abilities but my framework not. So I took some time and made this. It is very very easy to use, and if you have some quality animations, you could get quite a lot out of this. 

## How to use it?

This is very simple actually, you put the script in `StarterCharacterScripts` and you are good to go!
In the script there are
- [`Animation`](https://developer.roblox.com/en-us/api-reference/class/Animation) `CrouchIdle`
- [`Animation`](https://developer.roblox.com/en-us/api-reference/class/Animation) `CrouchWalk`
- [`Animation`](https://developer.roblox.com/en-us/api-reference/class/Animation) `Slide`
- [`NumberValue`](https://developer.roblox.com/en-us/api-reference/class/NumberValue) `SprintSpeed`
- [`NumberValue`](https://developer.roblox.com/en-us/api-reference/class/NumberValue) `WalkSpeed`

To use the animations provided in the Script itself, you will have to upload the animations to your account and then replace the `AnimationId`s in the `Animation` objects accordingly.
The `SprintSpeed` is the speed at which the character will sprint and the `WalkSpeed` is the speed at which the character will walk.

## Keybinds
- Sprint - `LeftShift`
- Crouch - `LeftControl` and `C`
- Slide - `LeftControl` and `C`

## Prerequisites 

- [`Animation`](https://developer.roblox.com/en-us/api-reference/class/Animation) `CrouchIdle`
- [`Animation`](https://developer.roblox.com/en-us/api-reference/class/Animation) `CrouchWalk`
- [`Animation`](https://developer.roblox.com/en-us/api-reference/class/Animation) `Slide`

## License 
### Mozilla Public License 2.0
Permissions of this weak copyleft license are conditioned on making available source code of licensed files and modifications of those files under the same license (or in certain cases, one of the GNU licenses). Copyright and license notices must be preserved. Contributors provide an express grant of patent rights. However, a larger work using the licensed work may be distributed under different terms and without source code for files added in the larger work.

Read the full document [here](https://github.com/Giant427/MovementHandler/blob/main/LICENSE).

## Download

Get it [here](https://www.roblox.com/library/7933550317/MovementHandler)
or from the [GitHub Repository](https://github.com/Giant427/MovementHandler)

P.s. this is my first time making something open-source please go easy on me and drop your feedback!!
