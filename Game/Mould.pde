class Mould
{
  float x;
  float y;
  float size;
  float speed;
  float StartingX;  //initial coordinates of x
  float StartingY;  //initial coordinates of y
  float appearanceDelay = random(20, 3000); 

  //Constructor
  Mould( float x, float y, float size, float speed)
  {
    this.x=x;
    this.y=y;
    this.size=size;
    this.speed= speed;
    this.StartingX=x;
    this.StartingY=y;
  }

  void show()
  {
    //to delay their appearence 
    if (appearanceDelay <= 0) {
      fill(150, 75, 0);
      ellipse(x, y, size, size);
      //move the mould down the screen
      y=y+speed;
      //when mould reaches the bottom, resets it position at the designated y value
      if (y> height)
      {
        y = 100;
        x = random(0, width);
      }
    } else {
      appearanceDelay--;
    }
  }
  void resetmould()
  {
    //Reset the postion when game is over
    x=StartingX;
    y=StartingY;
    appearanceDelay = random(20, 3000); // Set a new random appearance delay after resetting
  }
}
