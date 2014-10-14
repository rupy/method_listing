import types


esc = ["StringTypes", "TypeType"]
esc2 = ["__builtins__","__doc__","__file__","__name__","__package__"]

for t in dir(types):
    if t not in esc2:
        print t
        if t not in esc:
            print eval("types.%s.mro()" % t)
        print eval("dir(types.%s)" % t)
        print

