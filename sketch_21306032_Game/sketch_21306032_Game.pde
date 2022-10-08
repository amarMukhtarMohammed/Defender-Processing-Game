

//I woule like to give credit to these to sources as they helped in storing the the games highest score and incorperating buttons/splashscrren to my game
//I would also like to credit the last source learning about the atan2 function to add to my design for Attacker to follow Defenders
//Note all my animation images are from canva 
//https://www.baeldung.com/java-remove-start-end-double-quote                remove quotation marks
//https://beginnersbook.com/2013/12/how-to-convert-string-to-int-in-java/    string to int
//https://www.youtube.com/watch?v=v1kqMxsvElM                                adding buttons and incorperating atan2 function







static int windowNumber = 0;//decleares static variables
static int levelNumber = 0;
//initializes array of type Button objects
Button[] button;

void setup()
{
  //creates canvas
  size(500, 500);

  loadButtons();//renders splashscreen and in game screen ready to to be used
  player1 = new Defender(width/2, 50, 20, 20, 30, 50);//initializes player and explosion objects
  explosion1 = new Explosion(player1.x,player1.y,50,80);
  loadHighScore();
  renderBackground();
}

void draw()
{
  //directs user according to whcih option button is pressed
  background(200);
  switch(windowNumber) {
  case 0:
    menu();//homescreen initially loaded
    break;
  case 1:
    play();//loades game
    break;
  case 2:
    chooseLevel();//user capable of choosing level
    break;
  case 3:
    controls();//instructs user off controls
    break;
  case 4:
    about();//instructs user of game story cotext
    break;
  case 5:
    exit();//ends programme
    break;
  }
  //if chooseLevel is pressed, user directed acording to which level button is pressed
  switch(levelNumber) {
  case 0:
    break;
  case 1:
    level1();
    break;
  case 2:
    level2();
    break;
  case 3:
    level3();
    break;
  case 4:
    level4();
    break;
  case 5:
    level5();
    break;
  }
}

//creates button objects and stores in array
void loadButtons()
{
  button = new Button[12];//allocated space for 12 Button objects in array
  button[0] = new Button(width+200, 5, 150, 80, "menu");  //pre pressed to direct to splashscreen menu
  button[1] = new Button(25, 5, 150, 80, "Play");
  button[2] = new Button(25, 205, 150, 80, "Controls");
  button[3] = new Button(25, 305, 150, 80, "About");
  button[4] = new Button(25, 405, 150, 80, "Exit");
  button[5] = new Button(410, 450, 80, 40, "Back");
  button[6] = new Button(25, 105, 150, 80, "Choose Level");

  button[7] = new Button(205, 5, 150, 80, "Level 1");
  button[8] = new Button(205, 105, 150, 80, "Level 2");
  button[9] = new Button(205, 205, 150, 80, "Level 3");
  button[10] = new Button(205, 305, 150, 80, "Level 4");
  button[11] = new Button(205, 405, 150, 80, "Level 5");
}


//allows user to use mouse and interact with buttons
static boolean[] keys = new boolean[5];
void mousePressed()
{
  if (mouseButton == LEFT)
  {
    keys[3] = true;
  }
}
void mouseReleased()
{
  if (mouseButton == LEFT)
  {
    keys[3] = false;
  }
}
