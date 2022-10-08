
//displays splashScreen buttons when program is initialized also directs user 
void menu()
{
  button[0].drawThis();
  if (button[0].pressed()) {
    //levelNumber = 0;
    windowNumber = 0;
  }
  button[1].drawThis();
  if (button[1].pressed()) {
    windowNumber = 1;
  }
  button[2].drawThis();
  if (button[2].pressed()) {
    windowNumber = 3;
  }
  button[3].drawThis();
  if (button[3].pressed()) {
    windowNumber = 4;
  }
  button[4].drawThis();
  if (button[4].pressed()) {
    windowNumber = 5;
  }
  button[6].drawThis();
  if (button[6].pressed()) {
    windowNumber = 2;
  }
}

//displays and directs user to appropriate level if user selected to "Choose Level"
void chooseLevel()
{
  button[7].drawThis();
  if (button[7].pressed()) {
    levelNumber = 1;
  }
  button[8].drawThis();
  if (button[8].pressed()) {
    levelNumber = 2;
  }

  button[9].drawThis();
  if (button[9].pressed()) {
    levelNumber = 3;
  }
  button[10].drawThis();
  if (button[10].pressed()) {
    levelNumber = 4;
  }
  button[11].drawThis();
  if (button[11].pressed()) {
    levelNumber = 5;
  }


  button[5].drawThis();
  if (button[5].pressed()) {
    levelNumber = 0;
    windowNumber = 0;
  }
}

//displays text to user to instruct controls of game
void controls()
{
  fill(0, 0, 255);
  text("LEFT ARROW = Defender Move Left\n RIGHT ARROW = Defender Move Right\n SPACEBAR = Shoot Bullet", width/2, height/2);
  button[5].drawThis();
  if (button[5].pressed()) {
    windowNumber = 0;
  }
}

//displays text to user of game story
void about()
{
  fill(0, 255, 0);
  text("A 2D SIEGE GAME, WHERE THE DEFENDER \n IS LIMITED TO MOVING HORIZONTALLY \n ACROSS THE TOP OF THE CASTLE\n WALL, DROPING BOMBS ONTO \n ATTACKERS MOVING UP THE SCREEN \n SLOWLY BUT BE AWARE \n OF RED SUPER ATTACKERS!", width/2, height/2);
  button[5].drawThis();
  if (button[5].pressed()) {
    windowNumber = 0;
  }
}



//--------------------------------------------------IN_GAME_WINDOW------------------------------------------------------



//initialize in game arrayLists
ArrayList<Attacker> attackerList = new ArrayList();
ArrayList<Weapon> weaponList = new ArrayList();
ArrayList<SuperAttacker> superAttackerList = new ArrayList();


//initialize classes
Defender player1;
Explosion explosion1;
//Weapon rock1;

//declare constants


//declare variables
int PLAYING = 0;
int FINISHED = 1;

int gameMode = PLAYING;

int spawnTimer = 0;
int weaponCounter = 0;

int defenderScore = 0;
int defenderLives = 10;
int highScore = 0;

PImage backgroundWallImage;
PImage backgroundSkyImage;
PImage backgroundGrassImage;
int secPerAttackers = 0;



//ran when user playing game
void play()
{
  if (gameMode == PLAYING)
  {
    secPerAttackers = 60;//Every 60 secounds an Attacker will spawn
    loadBackground();//renders in game background
    player1.update();//creates Defender object
    player1.loadDefenderImages();//loads Defender's animation
    loadDefenderScore();//loads players score
    loadDefenderLives();//loads players lives
    spawnTimer++;//counter to determine number of Attackers and SuperAttackers to spawn 

    //spawns Attackers and SuperAttackers per given time
    if (spawnTimer % 1200 == 0)
    {
      attackerList.add(new SuperAttacker(((int) random((50), (width-50))), (height + 80), ((int) random(3, 6)), 50, 80));
    }
    if (spawnTimer % secPerAttackers ==0) //every 1 secound
    {
      attackerList.add(new Attacker(((int) random((50), (width-50))), (height+80), 0, 50, 80));
    }

    //creates Attacker objects
    for (int i = 0; i < attackerList.size(); i++)
    {
      Attacker currentAttacker = attackerList.get(i);
      currentAttacker.update();
      if (currentAttacker instanceof SuperAttacker)
      {
        //removes SuperAttacker and deducts score points if defender crashes with SuperAttackers
        if (player1.defenderCrashSuperAttacker(currentAttacker))
        {
          attackerList.remove(currentAttacker);
          defenderScore = -5;
          ;
        }
      } else if (currentAttacker instanceof Attacker)
      {
        //removes Attacker and deducts score points if defender crashes with SuperAttackers
        if (player1.defenderCrashAttacker(currentAttacker))
        {
          attackerList.remove(i);
          defenderScore = defenderScore - 5;
        }
      }
      //displays explosion object, removes bullet, removes Attacker and deducts point if collision between Attacker and bomb
      for (int index = 0; index < weaponList.size(); index++)
      {
        if (currentAttacker.attackerCrashWeapon(weaponList.get(index)))
        {
          explosion1.x = currentAttacker.x;
          explosion1.y = currentAttacker.y;
          explosion1.render();
          attackerList.remove(i);
          weaponList.remove(index);
          defenderScore++;
        }
      }
    }
    //creates Weapon object
    for (int i = 0; i < weaponList.size(); i++)
    {
      weaponList.get(i).update();
    }
  }
  //ends game if defender score is below minimum points required 
  if (defenderScore <= -1)
  {
    gameMode = FINISHED;
  }
  if (gameMode == FINISHED)
  {
    gameOver();
  }
  //removes bullet object from weaponList array if bullet goes off screen
  for (int i = 0; i < weaponList.size(); i++)
  {
    Weapon currentWeapon = weaponList.get(i);
    if (currentWeapon.y > (height + 25))
    {
      weaponList.remove(i);
    }
  }
  //removes Attacker object from attackerList array if goes off screen
  for (int i = 0; i < attackerList.size(); i ++)
  {
    Attacker currentAttacker = attackerList.get(i);
    if (currentAttacker.y < (0 - 80))
    {
      attackerList.remove(i);
    }
  }
  //removes SuperAttacker if exceeds canvas height
  for (int i = 0; i < superAttackerList.size(); i ++)
  {
    SuperAttacker currentSuperAttacker = superAttackerList.get(i);
    if (currentSuperAttacker.y < (0 - 80))
    {
      superAttackerList.remove(i);
      defenderLives--;
    }
  }
  button[5].drawThis();
  if (button[5].pressed()) {
    windowNumber = 0;
  }
}






//renders background
void loadBackground()
{
  int upperBackgroundMargin = 100;
  int lowerBackgroundMargin = 200;
  imageMode(CORNER);
  image(backgroundWallImage, 0, (upperBackgroundMargin), width, height-(lowerBackgroundMargin));
  image(backgroundSkyImage, 0, 0, width, upperBackgroundMargin);
  image(backgroundGrassImage, 0, (height-upperBackgroundMargin), width, lowerBackgroundMargin);
}



//key pressed function for user to interact with game
void keyPressed()
{
  if (key == CODED)
  {
    if (keyCode == LEFT)
    {
      player1.x = player1.x - player1.deltaX;
      player1.x = (int) constrain(player1.x, (0+(player1.gameObjectWidth/2)), (width-(player1.gameObjectHeight/2)));
      keys[0] = true;
    }
    //moves player down
    if (keyCode == RIGHT)
    {
      player1.x = player1.x + player1.deltaX;
      player1.x = (int) constrain(player1.x, (0+(player1.gameObjectWidth/2)), (width-(player1.gameObjectHeight/2)));
      keys[1] = true;
    }
  }
  //restarts game when 'r' is presed
  if (key == 'r')
  {
    defenderScore = 0;
    gameMode = PLAYING;
    setup();//restarts game
    for (int i = 0; i < attackerList.size(); i++)
    {
      attackerList.get(i).y = height + attackerList.get(i).gameObjectHeight;
    }
  }
  {
    //shoots Bullet object is spacebar is pressed

    if (key == ' ')
    {
      //rock1 = new Weapon(player1.x);//creates Bullet object
      //bullet1.deltaX = 10;//increases speed of bullet
      weaponCounter = weaponCounter + 1;
      weaponList.add(new Weapon(player1.x, 113, 6, 25, 25));
      keys[2] = true;
    }
  }
}
//key released function for user to interact with game
void keyReleased()
{
  if (key == CODED)
  {
    if (keyCode == LEFT)
    {
      keys[0] = false;
    }

    if (keyCode == RIGHT)
    {
      keys[1] = false;
    }
  }
  if (key == ' ')
  {
    keys[2] = false;
  }
}

//dispalys game over screen
void gameOver()
{
  background(255);
  fill(255, 0, 0);
  text("GAME OVER", width/2, height/2);
}
//displays score count and high score count 
void loadDefenderScore()
{
  fill(255, 0, 255);
  textSize(15);
  text("SCORE: " + defenderScore, ((width/2) - 25), height*0.025);
  if (defenderScore > highScore)
  {
    highScore = defenderScore;
  }
  storeHighScore();
  fill(255, 0, 0);
  text("HIGHSCORE: : " + highScore, ((width/2) - 25), height*0.05);
}
//displays defender Lives count
void loadDefenderLives()
{
  fill(#23D84E);
  text("LIVES: " + defenderLives, (30), 25);
}
//interatcs with file to store user highest score
void storeHighScore()//defenderScore, highScore
{
  if (defenderScore > highScore)
  {
    String numbers = "\""+ defenderScore + "\"";
    String[] list = (split(numbers, ' '));
    saveStrings("highScore.txt", list);
  } else {
    String numbers = "\""+ highScore + "\"";
    String[] list = (split(numbers, ' '));
    saveStrings("highScore.txt", list);// Writes the strings to a file, each on a separate line
  }
  loadHighScore();
}
//loads background images
void renderBackground()
{
  backgroundWallImage = loadImage("Images/backgroundWallImage.jpg");
  backgroundWallImage.resize(width, height);
  backgroundSkyImage = loadImage("Images/backgroundSkyImage.jpg");
  backgroundSkyImage.resize(width, height);
  backgroundGrassImage = loadImage("Images/backgroundGrassImage.jpg");
  backgroundGrassImage.resize(width, height);
}

//processes high score to store in external file
void loadHighScore()
{
  String scr;
  String[] lines = loadStrings("highScore.txt");
  //println("there are " + lines.length + " lines");
  for (int i = 0; i < lines.length; i++) {
    scr = lines[i];

    String result = scr.replaceAll("^\"|\"$", ""); //removes quotation marks
    int inum = Integer.parseInt(result); //converts from string to int
    highScore = inum;
  }
}

//fucntion to get angle given two object points
PVector getDirection(float x1, float y1, float x2, float y2) {
  PVector vec1 = new PVector(x1, y1);
  PVector vec2 = new PVector(x2, y2);
  PVector dir = new PVector();

  dir.set(PVector.sub(vec1, vec2));
  println(dir);
  dir.normalize();
  //dir.mult(resizeX(v));

  return dir;
}



//function that loads condtions for each level when "Choose Level" has been selected and appropriate level has been selected
void level1()
{
  secPerAttackers = 60;
  play();
  for (int i = 0; i < attackerList.size(); i ++)
  {
    Attacker currentAttacker = attackerList.get(i);
    currentAttacker.deltaY = ((int) random(1, 3));
  }
}
void level2()
{
  secPerAttackers = 60;
  play();
  for (int i = 0; i < attackerList.size(); i ++)
  {
    Attacker currentAttacker = attackerList.get(i);
    currentAttacker.deltaY = ((int) random(1, 3));
  }
}
void level3()
{
  secPerAttackers = 90;
  play();
  for (int i = 0; i < attackerList.size(); i ++)
  {
    Attacker currentAttacker = attackerList.get(i);
    currentAttacker.deltaY = ((int) random(3, 6));
  }
}
void level4()
{
  secPerAttackers = 120;
  play();
  for (int i = 0; i < attackerList.size(); i ++)
  {
    Attacker currentAttacker = attackerList.get(i);
    currentAttacker.deltaY = ((int) random(6, 9));
  }
}
void level5()
{
  secPerAttackers = 150;
  play();
  for (int i = 0; i < attackerList.size(); i ++)
  {
    Attacker currentAttacker = attackerList.get(i);
    currentAttacker.deltaY = ((int) random(9, 12));
  }
}
