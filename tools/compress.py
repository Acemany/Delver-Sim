from pygame import (display, image, error,
                    init, quit)
from pathlib import Path
from os import listdir
from sys import argv


def save_path(path: Path):
    load_progress = 0
    files = listdir(path)
    load_len = len(files)
    for f in files:
        load_progress += 1
        print(f"Compressing file {load_progress}/{load_len} \"{path/f}\"")
        # if f.split(".")[-1].lower() in ["bmp", "gif", "jpg", "jpeg", "lbm", "pbm", "pgm", "ppm", "pcx", "png", "pnm", "svg", "tga", "tif", "tiff", "webp", "xpm"]
        try:
            image.save(image.load(path/f), path/f)
        except error as e:
            print(f"Warning, \"{path/f}\" is not an image. Error:\n", e)
        except Exception as e:
            print("Error occured while compressing file:\n", e)
            raise e
            while 1:
                pass
    assert len(files) == load_progress


def compress_args():
    for i in argv[1:]:
        image.save(image.load(i).convert(), f"{i}_c.png")


gamedir = Path(__file__).parent.parent

init()
display.set_mode()
if len(argv) >= 2:
    compress_args()
else:
    save_path(gamedir/"assets/sprites")
quit()
