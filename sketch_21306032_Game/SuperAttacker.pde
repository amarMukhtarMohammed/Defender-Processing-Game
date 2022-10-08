class SuperAttacker extends Attacker//SuperAttacker class is a child class of Attacker class(parent class)
{
  //animation array

  final PImage [] superClimbers = new PImage[3];

  //construcrors
  SuperAttacker(int x, int y, int deltaY, int gameObjectWidth, int gameObjectHeight)
  {
    super(x, y, deltaY, gameObjectWidth, gameObjectHeight);
  }


  @Override
    void render()//displays SuperAttacker using animation array
  {
    for (int i = 0; i < superClimbers.length; i++)
    {
      superClimbers[i] = loadImage("Images/superClimber"+i+".png");
    }
    if (animationCounter < 10) {
      image(superClimbers[0], this.x, this.y, gameObjectWidth, gameObjectHeight);
    } else if (animationCounter < 19) {
      image(superClimbers[1], this.x, this.y, gameObjectWidth, gameObjectHeight);
    } else {
      image(superClimbers[2], this.x, this.y, gameObjectWidth, gameObjectHeight);
      animationCounter = 0;
    }
    animationCounter++;
  }

  @Override
    void move()//moves position of SuperAttacker
  {
    this.y = this.y - this.deltaY;
  }

  boolean superAttackerCrashWeapon(Weapon other)//function to detect collision between SuperAttacker and bullet Weapon
  {
    if ((other != null))
    {
      return((other.x > this.x) && (other.x < this.x + this.gameObjectWidth) && (other.y > this.y) && (other.y < this.y + this.gameObjectHeight));
    } else {
      return false;
    }
  }
}
