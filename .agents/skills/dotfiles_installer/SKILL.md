--- 
name: dotfiles_installer
description: Use this when the user want's to create a install script for a linux dotfiles and symlink it 
--- 

When writing the install script make sure hte install script will follow the step bellow to check and pass each one before moving on to maintain stabilit

## PreFlighg step 

make sure the scritp alwasy check the distro we are currenlty in so we can adjust what package manager to use and what version of the package to install

Also check if the tools available to install the dotfiles are availabel for this dotifles packaages 
- hyprland
- waybar
- rofi
- kitty
- swaync 
- wallust 
- matugen 

Check for each distributoins repository 
make sure the user does not this as root to prevent unwatned break

## Bakcupup step

Backup preexisiting config files in the format of 
`~/.config/hypr` -> `~/.config/hypr.bak-[timestamp]`
Make sure the scirpt print where it has been backed up 

## Install packaages

After everyting is done. and comfirmed install all the required packages and dependecides needed in this dotilfes for:
- hyprland
- waybar
- rofi
- kitty
- swaync 
- wallust 
- matugen 

And based on the result of the distro check use the command for each corresponding dsitribution, `pacman`, `dnf`, `apt`, These three are the main target

## Deploy configs 

copy everthing insside teh ~/dotifles and paste it to the correspoting $hHOME/.configs/ and $HOME/.local/bin

## Give Permission 

Give permission to run the commans inside ~/.local/bin 

## Post install 
install required fonts which is `Jetbrains Nerd Font mono foe each distributions`

After all of that print a comfirmation message saing what has been installed, copied and modified and a summary of where the backupe files if there exist any 

## Practical tips 
use color coded logging 

```bash 
```bash
info()    { echo -e "\e[34m[INFO]\e[0m $*"; }
success() { echo -e "\e[32m[OK]\e[0m $*"; }
warn()    { echo -e "\e[33m[WARN]\e[0m $*"; }
error()   { echo -e "\e[31m[ERROR]\e[0m $*"; exit 1; }
```
```
```
```
