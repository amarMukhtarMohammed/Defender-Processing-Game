class Weapon extends GameObject //Weapon class is a child class of GameObject(parent class)
{
  //define array and variables for animation series
  final PImage [] bulletImages = new PImage[3];
  int animationCounter = 0;

  //constuctors
  Weapon(int x, int y, int deltaY, int gameObjectWidth, int gameObjectHeight)
  {
    super(x, y, deltaY, gameObjectWidth, gameObjectHeight);
  }

  @Override
    void render()//displays Weapon
  {
    for (int i = 0; i < bulletImages.length; i++)
    {
      bulletImages[i] = loadImage("Images/bullet"+i+".png");
      bulletImages[i].resize(gameObjectWidth, gameObjectHeight);
    }
    if (animationCounter < 10 && animationCounter > 1) {
      image(bulletImages[0], this.x, this.y, gameObjectWidth, gameObjectHeight);
    } else if (animationCounter < 19) {
      image(bulletImages[1], this.x, this.y, gameObjectWidth, gameObjectHeight);
    } else {
      image(bulletImages[2], this.x, this.y, gameObjectWidth, gameObjectHeight);
      animationCounter = 0;
    }

    animationCounter++;
  }

  @Override
    void move()//moves Weapon
  {
    y = y + deltaY;
  }
}
