## Console paint
It's a simple application where you can draw text images

### Run

`bin/editor
`

The editor supports 7 commands:

1. **I M N**. Create a new _M_ x _N_ image with all pixels coloured white (O).
2. **C**. Clears the table, setting all pixels to white (O).
3. **L X Y C**. Colours the pixel (_X,Y_) with colour C.
4. **V X Y1 Y2 C**. Draw a vertical segment of colour _C_ in column _X_ between rows _Y1_
   and _Y2_ (inclusive).
5. **H X1 X2 Y C**. Draw a horizontal segment of colour _C_ in row _Y_ between columns
   _X1_ and _X2_ (inclusive).
6. **F X Y C**. Fill the region R with the colour _C_. _R_ is defined as: Pixel (_X,Y_)
   belongs to R. Any other pixel which is the same colour as (_X,Y_) and shares a
   common side with any pixel in _R_ also belongs to this region.
7. **S**. Show the contents of the current image
8. **X**. Terminate the session
