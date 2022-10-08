class Defender extends GameObject//Defender class is a child class of GameObject(parent class)
{

  //animation array
  final PImage [] defenderImages = new PImage[2];

  //constriuctors
  Defender(int x, int y, int deltaX, int deltaY, int gameObjectWidth, int gameObjectHeight)
  {
    super(x, y, deltaX, deltaY, gameObjectWidth, gameObjectHeight);
  }


  @Override
    void render()//loads Defender images
  {
    for (int i = 0; i < defenderImages.length; i++)
    {
      defenderImages[i] = loadImage("Images/defender"+i+".png");
      defenderImages[i].resize(gameObjectWidth, gameObjectHeight);
    }
  }

  //displays defender image when appropriate key is pressed
  void loadDefenderImages()
  {
    if (keys[0] == true)
    {
      image(defenderImages[1], x, y, gameObjectWidth, gameObjectHeight);//draws image
    }

    if (keys[1] == true) {
      image(defenderImages[0], x, y, gameObjectWidth, gameObjectHeight);//draws image
    } else {
      image(defenderImages[1], x, y, gameObjectWidth, gameObjectHeight);//draws image
    }
  }



  @Override
    void move()
  {
  }

  boolean defenderCrashAttacker(Attacker other)//function to detect collision between Defender and Attacker
  {
    if (other != null)
    {
      return(abs(this.x - other.x) < gameObjectWidth && abs(this.y - other.y) < (gameObjectHeight/2));
    } else {
      return false;
    }
  }

  boolean defenderCrashSuperAttacker(Attacker other)//function to detect collision between Defender and SuperAttacker
  {
    if (other != null)
    {
      return((abs(this.x - other.x) < gameObjectWidth) && (abs(this.y - other.y) < (gameObjectHeight/2)));
    } else {
      return false;
    }
  }
}
