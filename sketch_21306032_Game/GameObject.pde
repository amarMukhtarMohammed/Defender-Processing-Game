abstract class GameObject {

  int x, y, deltaX, deltaY;
  final int gameObjectWidth, gameObjectHeight;

  //constructors
  GameObject(int x, int y, int deltaX, int deltaY, int gameObjectWidth, int gameObjectHeight)
  {
    this.x = x;
    this.y = y;
    this.deltaX = deltaX;
    this.deltaY = deltaY;
    this.gameObjectWidth = gameObjectWidth;
    this.gameObjectHeight = gameObjectHeight;
  }
  GameObject(int x, int y, int deltaY, int gameObjectWidth, int gameObjectHeight)
  {
    this.x = x;
    this.y = y;
    this.deltaY = deltaY;
    this.gameObjectWidth = gameObjectWidth;
    this.gameObjectHeight = gameObjectHeight;
  }
  GameObject(int x, int y, int gameObjectWidth, int gameObjectHeight)
  {
    this.x = x;
    this.y = y;
    this.gameObjectWidth = gameObjectWidth;
    this.gameObjectHeight = gameObjectHeight;
  }


  //methods
  void update()
  {
    render();
    move();
  }
  abstract void render();
  abstract void move();
}
