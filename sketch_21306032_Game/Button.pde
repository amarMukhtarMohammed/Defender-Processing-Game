class Button {

  //declares Buttons variables
  float posX, posY, horizontalScale, verticalScale;
  String text;

  //constructors
  Button (float x, float y, float w, float h, String t) {
    posX = x;
    posY = y;
    horizontalScale = round(w);
    verticalScale = round(h);
    text = t;
  }

  //renders button
  void drawThis()
  {
    if (mouseInside()) {
      fill(100);
      rect(posX, posY, horizontalScale, verticalScale);
      fill(255);
      textSize(20);
      textAlign(CENTER, CENTER);
      text(text, posX + horizontalScale/2, posY + verticalScale/2);
    } else {
      fill(200);
      rect(posX, posY, horizontalScale, verticalScale);
      fill(0);
      textSize(20);
      textAlign(CENTER, CENTER);
      text(text, posX + horizontalScale/2, posY + verticalScale/2);
    }
  }

  //variable that detects if mouse is inside button
  boolean mouseInside() {
    if (mouseX >= posX && mouseX <= posX + horizontalScale && mouseY >= posY && mouseY <= posY + verticalScale)

      return true;

    return false;
  }

  //variable that detects if mouse is inside button
  boolean pressed() {
    if (mouseInside() && (keys[3] == true))
    {
      return true;
    } else {
      return false;
    }
  }
}
