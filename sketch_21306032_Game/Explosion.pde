class Explosion extends GameObject
{
  //members
  int x;
  int y;
  int gameObjectWidth = 50;
  int gameObjectHeight = 80;

  PImage image2 = loadImage("Images/climber3.png");
  int explosionCount;

  //constructors
  Explosion(int x, int y, int gameObjectWidth, int gameObjectHeight)
  {
    super(x, y, gameObjectWidth, gameObjectHeight);
  }

  @Override
  void move()
  {
  }

  //decleares render method
  @Override
    void render()
  {
    //draws explosion image for set time
    if (explosionCount % 200 == 0)
    {
      image(image2, x, y, gameObjectWidth, gameObjectHeight);//draws image
      explosionCount = explosionCount + 1;//explosion count
    }
    explosionCount = 0;//reseting explosion count to 0 to repeat
  }
}
