class Attacker extends GameObject//Attacker class is a child class of GameObject(parent class)
{

  //define array and variables for animation series
  final PImage [] climbers = new PImage[4];
  int animationCounter = 0;

  //constructors
  Attacker(int x, int y, int deltaY, int gameObjectWidth, int gameObjectHeight)
  {
    super(x, y, deltaY, gameObjectWidth, gameObjectHeight);
  }

  @Override
    void render()//displays animation array
  {
    for (int i = 0; i < climbers.length; i++)
    {
      climbers[i] = loadImage("Images/climber"+i+".png");
    }
    if (animationCounter < 10 && animationCounter > 1) {
      image(climbers[0], this.x, this.y, gameObjectWidth, gameObjectHeight);
    } else if (animationCounter < 19) {
      image(climbers[1], this.x, this.y, gameObjectWidth, gameObjectHeight);
    } else {
      image(climbers[2], this.x, this.y, gameObjectWidth, gameObjectHeight);
      animationCounter = 0;
    }
    animationCounter++;
  }


  @Override
    void move()//directs Attacker
  {
    getDefenderDirection();
  }

  void getDefenderDirection()//points Attacker in accordance to players X position
  {
    //gets the direction from the attacker towards the initial position, setting the velocity
    PVector direction = getDirection(player1.x, player1.y, this.x, this.y);
    x += direction.x;
    y += direction.y - deltaY;
  }

  boolean attackerCrashWeapon(Weapon other)//function to detect collision between attacker and bullet Weapon
  {
    if ((other != null))
    {
      return((other.x > this.x) && (other.x < this.x + this.gameObjectWidth) && (other.y > this.y) && (other.y < this.y + this.gameObjectHeight));
    } else {
      return false;
    }
  }
}
