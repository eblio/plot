# Plot
Draw graphs on FiveM.

## Installation
* Download the resource ;
* Drag and drop it in your resources folder ;
* Add ```start plot``` to you ```server.cfg``` ;
* Add ```client_script '@plot/plot.lua'``` in the ```resource.lua``` of the resource that will use the script.

## How to use
### Commands
Commands can be used don't need a new script to work, need to be run in game.
```lua
/plot create [ID] -- Creates a new plot.

/plot show [ID] -- Shows the plot (needs coordinates).

/plot graph [ID] [x's] and [y's] end -- Changes the x and y coordinates of the dots.

/plot size [ID] [x] [y] -- Changes the size of the plot.

/plot coords [ID] [x] [y] [z] -- Changes the coordinates of the plot (relative to your position).

/plot color [ID] [r] [g] [b] [a] -- Changes the color of the plot

/plot nbraxis [ID] [nbr] -- Changes the amount of values wrote on the axis.
``` 

### Functions
Functions need to be in an other resource.
```lua
Plot.Create(id) -- Creates a new plot.

Plot.Show(id) -- Shows the plot (needs coordinates).

Plot.Graph(id, _x, _y) -- Changes the x and y coordinates of the dots.

Plot.Size(id, _x, _y) -- Changes the size of the plot.

Plot.Coords(id, _x, _y, _z) -- Changes the coordinates of the plot (relative to your position).

Plot.Color(id, _r, _g, _b, _a) -- Changes the color of the plot

Plot.NbrAxis(id, _nbrOfAxis) -- Changes the amount of values wrote on the axis.

Plot.Remove(id) -- Removes the plot.

Plot.Destroy(id) -- Destroys the plot.
``` 

## Examples
### Screenshots
https://imgur.com/a/neJHclD

### Videos

## Update
No update.

## Note
* This is alggy when you draw around 3000 lines.
* Probably a bit buggy, I tried to make this the most user friendly as possible.
