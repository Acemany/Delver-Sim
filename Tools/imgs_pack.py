from pygame import (display, image, error,
                    init, quit,
                    Surface)
from pathlib import Path
from os import listdir
from sys import argv


bb = "walk_down"


def stack_images():
    for bb in ("attack_side",
               "attack_up",
               "attack_down"):
        oldimg = [image.load(i).convert_alpha() for i in [f"{bb}_{j}.png_out.png" for j in range(3)]]  # listdir(Path(__file__).parent)]

        outimg = Surface((64*len(oldimg), 64)).convert_alpha()
        outimg.fill((0, 0, 0, 0))
        # outimg.set_colorkey((255, 0, 255))

        for j, i in enumerate(oldimg):
            outimg.blit(i, (64*j, 0))
        image.save(outimg, f"{bb}.png")


def save_path(path: Path):
    load_progress = 0
    files = listdir(path)
    load_len = len(files)
    for f in files:
        load_progress += 1
        print(f"Compressing file {load_progress}/{load_len} \"{f}\"")
        # if f.split(".")[-1].lower() in ["bmp", "gif", "jpg", "jpeg", "lbm", "pbm", "pgm", "ppm", "pcx", "png", "pnm", "svg", "tga", "tif", "tiff", "webp", "xpm"]
        try:
            image.save(image.load(f), f)
        except error as e:
            print(f"Warning, \"{f}\" is not an image. Error:\n", e)
        except Exception as e:
            print("Error occured while compressing file:\n", e)
            while 1:
                pass
    assert len(files) == load_progress


def compress_args():
    for i in argv[1:]:
        image.save(image.load(i), f"{i}.png")


init()
display.set_mode()

stack_images()
quit()
