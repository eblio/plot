# Plot
Draw graphs on FiveM.

## Installation
* Download the resource ;
* Drag and drop it in your resources folder ;
* Add ```start plot``` to you ```server.cfg``` ;
* Add ```client_script '@plot/plot.lua'``` in the ```resource.lua``` of the resource that will use the script.

## How to use
### Commands
Commands can be used don't need a new script to work.
```python
/plot create [ID] # Creates a new plot.

/plot show [ID] # Shows the plot (needs coordinates).

/plot graph [ID] [x's] and [y's] end # Changes the x and y coordinates of the dots.

/plot size [ID] [x] [y] # Changes the size of the plot.

/plot coords [ID] [x] [y] [z] # Changes the coordinates of the plot (relative to your position).

/plot color [ID] [r] [g] [b] [a] # Changes the color of the plot

/plot nbraxis [ID] [nbr] # Changes the amount of values wrote on the axis.
``` 

### Functions
Functions need to be in an other resource.
```python
Plot.Create(id) # Creates a new plot.

Plot.Show(id) # Shows the plot (needs coordinates).

Plot.Graph(id, _x, _y) # Changes the x and y coordinates of the dots.

Plot.Size(id, _x, _y) # Changes the size of the plot.

Plot.Coords(id, _x, _y, _z) # Changes the coordinates of the plot (relative to your position).

Plot.Color(id, _r, _g, _b, _a) # Changes the color of the plot

Plot.NbrAxis(id, _nbrOfAxis) # Changes the amount of values wrote on the axis.

Plot.Remove(id) # Removes the plot.

Plot.Destroy(id) # Destroys the plot.
``` 

## Options 
* Color of the text : ```client.lua``` line 1 : ```local color = {r = 37, g = 175, b = 134, alpha = 255}```
* Font of the text : ```client.lua``` line 2 : ```local font = 0``` Available fonts : https://imgur.com/a/oV3ciWs
* Time on screen : ```client.lua``` line 2 : ```local time = 500```
* Enable or disable the log : ```server.lua``` line 1 : ```local logEnabled = true```

## Update
#### V1.1
* The text display an exact amount of time (thanks to @SaltyGrandpa).
* Added "the person" at the beginning of the text (```Line 7``` if you want to change the language).
* Using /me multiple times doesn't make it unreadable.
#### V1.2
* Bugs fixes.
* Changed the native color and removed the shadow and the outline (you can still reactivate it).
* Now draw when you are close to the person (50 m).

## Note
* This couldn't work if you use a custom chat resource.
* This could conflict with other /me scripts (just disable them).
