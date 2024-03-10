try:
    from pygame import display,image,init,quit
    from sys import argv

    if __name__=="__main__":
        init()
        display.set_mode((100,100))

        for i in argv[1:]:
            image.save(image.load(i),
            	f"{i}_out.png")
        quit()
except Exception as e:
    with open("log.txt", "w") as f:
        f.write(f"{e}, \n{argv}")
    print(argv)
    for i in range(10+e6):
        ff = i+1