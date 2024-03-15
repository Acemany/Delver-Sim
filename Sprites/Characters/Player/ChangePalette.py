from pygame import (display, image,
                    init, quit as squit,
                    Color)
from pathlib import Path
from typing import Dict
from os import listdir
from sys import exit


def change_palette(palette: Dict[Color, Color]):
    for bb in listdir(gamedir):
        if bb.split(".")[-1] in ["py", "import"]:
            continue
        oldimg = image.load(bb).convert_alpha()
        
        for y in range(oldimg.get_height()):
            for x in range(oldimg.get_width()):
                if oldimg.get_at((x, y))[:3] in palette:
                    oldimg.set_at((x, y), palette[oldimg.get_at((x, y))[:3]])
        image.save(oldimg, f"{bb.split(".")[0]}.C.png")


init()
display.set_mode()
gamedir = Path(__file__).parent
change_palette({(16, 49, 63): (41, 163, 49),
                (86, 28, 20): (41, 163, 49),
                (124, 40, 27): (245, 116, 37),
                (210, 170, 123): (222, 164, 135),
                (128, 104, 67): (214, 140, 105),
                (236, 226, 226): (89, 57, 35)})

squit()
exit()