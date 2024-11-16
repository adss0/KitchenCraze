
Topping [] toppings;
Mould[] moulds;
Food FoodNew;

PImage BI; //BackgorundImage
PImage BS; //Brugerselection
PImage PS; //PizzaSelection
PImage P1; //Pizza image
PImage B1; //burgerimage


int Level=1;
int score;
int BoxWidth = 350;   //Width of selection box
int BoxHeight = 300;  //height of slection box
int PizzaBoxX = 600;
int PizzaBoxY = 30;
int BurgerBoxX = 600;
int BurgerBoxY = 420;
int livesLeft = 5;  //Total numbers of lives

boolean GameOver = false;    //when game is over
boolean MouseIsDragging=false;  //when mouse is dragging the topping
boolean HighestScore =false;   // to choose if the current score is a high score
boolean PageOne=true;   // PageOne displays the introduction
boolean PageTwo=false;  // PageTwo displays the option to choose the food
boolean PageThree=false;  //PageThree shows the game being played
boolean LeaderBoard=false;  //show the leaderboard screen
boolean ContinueToNextLevel=false;
boolean NameEntered=false;

String inputText = "Your Name here";  //Shown on the Text input screen
String filePath= "./Highscores.txt" ;  //high score file
String[] lines;
String[] toppingNames = {"cheese", "onion", "mushrooms", "tomatoe", "sausage", "olives"};
ArrayList<String>displaytoppingslist = new ArrayList<String>();
String inputTextString = "Your Name here";

void setup()

{
  size(1000, 800);
  //resizing and loading in the images
  BI=loadImage("Background.png");
  BI.resize(1000, 800);
  P1 = loadImage("imagepizza.png");
  B1= loadImage("burgerbun.png");
  BS= loadImage("burgerselection.png");
  BS.resize(BoxWidth, BoxHeight);
  PS= loadImage("pizzaselection.png");
  PS.resize(BoxWidth, BoxHeight);

  // loading topping images using a for loop
  toppings = new Topping[6];
  for (int i = 0; i < toppings.length; i ++) {
    toppings[i] = new Topping(toppingNames[i]+".png", i * 100 + 145, 20, 40);
  }


  //array of moulds
  moulds= new Mould[18];
  for ( int m=0; m<moulds.length; m++) {
    moulds[m]= new Mould(random(0, 800), 100, 10, random(0.2, 0.4));
  }

  // Generate random index to select a random name from the array 'toppingStrings'
  String randomTopping = toppingNames[int(random(toppingNames.length))];
  //Add the extratcted to the array list
  displaytoppingslist.add(randomTopping);

  //Add the names until the arraylist 'displaytoppingslist' reaches a limit of four
  while (displaytoppingslist.size()<4) {
    randomTopping = toppingNames[int(random(toppingNames.length))];
    if (!displaytoppingslist.contains(randomTopping)) {
      displaytoppingslist.add(randomTopping);
    }
  }
  frameRate(60);
}

void draw()
{
  if (PageOne)
  {
    //set background image for the PageOne

    image(BI, 0, 0);
    fill(0);
    textSize(45);
    textAlign(CENTER);
    text("Welcome to Kitchen Craze", width / 2, height/2.2);

    fill(0);
    textAlign(CENTER);
    textSize(20);
    text("Enter your name below and press Enter to start", width/2, height/1.9);
    //Display input box
    fill(128, 128, 128);
    rectMode(CENTER);
    rect(width/2, height/1.65, 320, 80);
    //Display what name would be shown in the iput box

    fill(250);
    textAlign(CENTER);
    text(inputText, width/2, height/1.65);

    PageTwo=false;
    return;
  }


  if (PageTwo) {

    background(239, 230, 213);
    //set the coordiantes of Pizza and burger images
    image(BS, BurgerBoxX, BurgerBoxY );
    image(PS, PizzaBoxX, PizzaBoxY );

    fill(200, 220);
    rectMode(CORNER);
    rect(50, 50, 500, 400, 10);

    // Subtitle
    fill(0);
    textSize(20);
    text("Press on top of the image to select your food", 70, 600);

    // Display food options
    textSize(20);
    fill(33, 150, 243);
    text("Pizza", PizzaBoxX + 150, PizzaBoxY + 350);
    text("Burger", BurgerBoxX + 150, BurgerBoxY + 350);

    // Instructions
    textSize(20);
    textAlign(LEFT);
    text(" Instructions:", 70, 80);
    textSize(16);
    text("- Drag ingredients from the top onto the moving food.", 70, 120);
    text("- If pizza is selected, it will bounce once at the screen's end.", 70, 160);
    text("- If burger is selected, it will move diagonally across the screen.", 70, 200);
    text("- If a falling mould touches the dragged ingredient, a life is deducted.", 70, 240);
    text("- The ingredient resets to its original position. You have five lives.", 70, 280);
    text("- Adding ingredients from the top right list boosts the score by two.", 70, 320);
    text("- Add all ingredients to progress to the next level.", 70, 360);
    text("- After each level, the food's speed increases.", 70, 400);




    return;
  }

  if (PageThree) {

    background(0);
    //Display the food and the toppings list
    ToppingsList();
    FoodNew.display();

    //Loop through the topping array
    for (int i = 0; i < toppings.length; i++) {
      Topping topping = toppings[i];
      //render the topping
      topping.render();
      // split the name from the string
      String[] splitoftopping = split(topping.imageURL, '.');
      //extract the name from and store it in another string
      String characteroftopping = splitoftopping[0];
      // check for collision between food and topping
      if (collision(topping, FoodNew ) && !topping.ToppingIsAttached) {

        // Increment the score based on if the toppingname is from the displayed list
        if (displaytoppingslist.contains(characteroftopping) ) {
          score=score+2;
          displaytoppingslist.remove(characteroftopping);
        } else {
          score++;
        }

        //create new instance of topping
        Topping newTopping = topping.createNewInstance();
        //create an array with increased length

        int leng= toppings.length;
        Topping [] newToppings = new Topping[leng + 1];
        //copy to the exisiting data to the new array
        System.arraycopy(toppings, 0, newToppings, 0, leng);
        //Add the newly made topping to the end of the new array and reference to it
        newToppings[leng] = newTopping;
        toppings=newToppings;
        // reset the coordinates of collided topping to original
        topping.reset();
        newTopping.ToppingIsAttached = true;
        newTopping.ToppingIsResized=true;
      }
      //update the coordinates of the newly made topping to match the food
      if (topping.ToppingIsAttached== true) {
        topping.x = FoodNew.FoodX + topping.ToppingOffset;
        topping.y = FoodNew.FoodY + topping.ToppingOffset;
        topping.render();
      }
      //loop through to display the moulds
      for (Mould m : moulds) {
        m.show();
        //If the food reaches the end of the screen, topping collides with mould, set the game to be over
        if ( FoodNew.FoodX+ 100/2 <0 || (collision(topping, m) && livesLeft <= 0) ) {

          GameOver = true;
          PageThree=false;
          PageTwo=false;
          PageOne=false;
        }
      }
    }
    //check if the displayed list is empty, if it is empty, continue to next level
    if (displaytoppingslist.isEmpty()) {
      ContinueToNextLevel=true;
      PageThree=false;
      PageTwo=false;
      PageOne=false;
      //Display text if the user passes the level
      textAlign(CENTER);
      fill(255);
      textSize(30);
      text("Congrats! you made it past this level", width/2, height/2 -25);
      text("Press 'C' to continue to the next level", width/2, height/2+25);
    }

    //Display the score and the level
    textAlign(CENTER);
    textSize(20);
    fill(255, 0, 0);
    text("Level: " +Level, 60, 30);
    text("SCORE: " + score, 60, 60);


    showHearts();
  }

  // Game over screen
  if (GameOver) {
    //text that appears after game is over
    fill(255);
    textSize(40);
    textAlign(CENTER);
    text("Gameover", width/2, height/2);
    textSize(30);
    text( "Press Space bar to restart the game", width/2, height/2+100);
    text(" Press L to see the leader board", width/2, height/2+150);
    return;
  }
  //set the leaderboard screen
  if (LeaderBoard) {
    background(0);
    //display restart instructions
    fill(255);
    textSize(35);
    textAlign(CENTER);
    text( "Press Space bar to restart the game", width/2, 700);

    int loopLimit =Math.min(5, lines.length);  //ensure that the loop won't iterate beyond beyond 5
    int startingX = 400;  //  X coordinate
    int startingY = 200;  //  Y coordinate
    int rowSpacing = 80;  //  spacing between rows
    int cellWidth = 180;  //  width of each cell



    fill(255);
    textSize(30);
    text("LEADER BOARD", startingX +cellWidth/2, startingY-125);

    rect(startingX, startingY - 80, cellWidth, 30);
    rect(startingX + cellWidth, startingY - 80, cellWidth, 30);
    textSize(20);
    fill(0);
    rect(startingX, startingY - 80, cellWidth-6, 30-6);
    rect(startingX + cellWidth, startingY - 80, cellWidth-6, 30-6);
    fill(255);

    text("Name", startingX, startingY - 72);
    text("Score", startingX + cellWidth, startingY - 72);



    fill(255);
    textSize(20);
    //display highscores from the lines array after splitting them
    int i=0;
    for ( int j=lines.length -1; j>lines.length -loopLimit; j--) {

      //lines=sort(lines);
      String[] SCORE = split(lines[j], ',');

      fill(255);
      rect(startingX, startingY + i * rowSpacing, cellWidth, rowSpacing);
      rect(startingX + cellWidth, startingY + i * rowSpacing, cellWidth, rowSpacing);

      fill(0);
      rect(startingX, startingY + i * rowSpacing, cellWidth-6, rowSpacing-6);
      rect(startingX + cellWidth, startingY + i * rowSpacing, cellWidth-6, rowSpacing-6);



      fill(255);
      text(SCORE[0], startingX, startingY + i * rowSpacing);
      text(SCORE[1], startingX + cellWidth, startingY + i * rowSpacing);
      i++;
    }
    return;
  }
}


void keyPressed()
{
  //key functions to based on the game stage
  if  (key== ' ') {
    if (GameOver) {
      storeHighScore();
      resetgame();
      score=0;
      GameOver=false;
      PageTwo = true;
    } else if ( LeaderBoard) {
      storeHighScore();
      resetgame();
      score=0;
      LeaderBoard=false;
      PageTwo = true;
    }
  } else if
    (key==ENTER && PageOne && NameEntered && inputText.length() > 0) {
    PageTwo =true;
    PageOne=false;
  } else if (key==ENTER && ! NameEntered ) {
    fill(255, 0, 0);
    text(" Error, please enter your name", width/2, height/1.45);
  } else if (key == 'l' && GameOver) {
    storeHighScore();
    LeaderBoard=true;
    GameOver=false;
  } else if (key== 'c' && GameOver==false && ContinueToNextLevel ) {
    ContinueToNextLevel=false;
    resetgame();
    FoodNew.SpeedX=FoodNew.SpeedX*1.25;
    FoodNew.SpeedY=FoodNew.SpeedY*1.25;
    PageThree=true;
    Level=Level+1;
  }


  //key input for PageOne
  if (key >= ' ' && key <= '~' && PageOne && inputText.length() < 30) {
    //allowing input text on PageOne
    if (inputText.equals(inputTextString)) {
      inputText = ""; // Set the string to be empty if a word is entered
    }
    inputText += key;
    NameEntered=true;
  } else if (keyCode == BACKSPACE && inputText.length() > 0) {
    //backspace used to delete text during PageOne
    inputText = inputText.substring(0, inputText.length() - 1);
  }
}
void mouseDragged() {
  for (Topping topping : toppings) {
    float distance = dist(topping.x, topping.y, mouseX, mouseY);
    if (distance <= 50) {
      // set coordinates of topping to mouse coordinates to allow it to be dragged
      topping.x = mouseX;
      topping.y = mouseY;
      MouseIsDragging = true;
      break;
    }
  }
}

//Reset the location of topping if it isn't attached, colliding and if the mosue is release
void mouseReleased()
{
  for (Topping topping : toppings) {
    if (topping.ToppingIsAttached == false && PageThree && !collision(topping, FoodNew) ) {
      topping.reset();
    }
  }
}

// Checking collision between food and topping
boolean collision(Topping topping, Food f) {
  float halfToppingDistance= topping.Dimensions/2;
  float halfFoodDimenensions=f.FoodDimensions/2;
  float dis = dist(topping.x + halfToppingDistance, topping.y + halfToppingDistance, f.FoodX + halfFoodDimenensions, f.FoodY + halfFoodDimenensions );
  return dis <= halfToppingDistance + halfFoodDimenensions;
}

//Checking collision between topping and mould
boolean collision(Topping topping, Mould mould )
{
  float toppingRadius = topping.Dimensions / 2;
  float mouldRadius = mould.size/2;

  if (!topping.ToppingIsAttached && mould.y >=150) {
    float space = dist(topping.x + toppingRadius, topping.y + toppingRadius, mould.x, mould.y );
    if (space <= toppingRadius + mouldRadius) {
      livesLeft --;
      topping.reset();
      showHearts();
      return true;
    } else {
      return false;
    }
  } else {
    return false;
  }
}



void resettoppings()
{
  //create new array with the same length as toppingStrings
  toppings= new Topping[toppingNames.length];

  //Initalizing each topping object and passing in the constructor values
  for (int i = 0; i < toppings.length; i ++) {
    toppings[i] = new Topping(toppingNames[i]+ ".png", i * 100 + 100, 20, 40);
  }
}
void resetgame()
{
  //Reset game to its original state
  Level=1;
  livesLeft = 5;
  ResetToppingsList();
  resettoppings();
  FoodNew.resetfood();
  resetallmoulds();
}

void storeHighScore()
{
  // loading highscores into the stirng lines
  lines=loadStrings("Highscores.txt");

  //Compare the current score to see if it is a high score
  for (int e=0; e<lines.length; e++)
  {
    String [] SCORE = split(lines[e], ',');

    if (score < Integer.parseInt(SCORE[1])) {
      HighestScore=false;
    } else {
      HighestScore=true;
    }
  }
  //save the new highscore
  if (HighestScore) {
    lines= append(lines, inputText + ","+str(score));

    saveStrings("Highscores.txt", lines);
  }
}



void resetallmoulds()
{
  //loop through the array to reset the moulds
  for (Mould mould : moulds) {
    mould.resetmould();
  }
}




void mousePressed() {
  if (PageTwo) {
    // Select food by clicking in between the boxes
    if (mouseX >= PizzaBoxX && mouseX <= PizzaBoxX + BoxWidth &&
      mouseY >= PizzaBoxY && mouseY <= PizzaBoxY + BoxHeight) {
      selectPizza();
    } else if (mouseX >= BurgerBoxX && mouseX <= BurgerBoxX + BoxWidth &&
      mouseY >= BurgerBoxY && mouseY <= BurgerBoxY + BoxHeight) {
      selectBurger();
    }
  }
}

void selectPizza() {
  PageThree = true;
  // create a new instance
  FoodNew = new Pizza(P1, 3, 0.45, 1000, 150, 100);
  PageOne = false;
  PageTwo = false;
}

void selectBurger() {
  PageThree = true;
  // create a new instance
  FoodNew = new Burger(B1, 2.5, 0.35, 1000, 150, 100);
  PageOne = false;
  PageTwo = false;
}


void ToppingsList()
{
  rectMode(CENTER);
  fill(65, 105, 225);
  rect(850, 40, 295, 45, 10);

  textAlign(CENTER);
  textSize(14);
  fill(255, 255, 0);
  int i= 0;
  for ( String top : displaytoppingslist) {
    String[] splitURL = split(top, '.');
    String toppingNames = splitURL[0];
    text(toppingNames, 770+i*65, 40);
    i=i+1;
  }
  text("ADD:", 720, 40);
}

void ResetToppingsList()
{
  //clear the displaytoppingslist from previous games
  displaytoppingslist.clear();
  //readd topping list randomly until the size is 4
  while (displaytoppingslist.size() < 4) {
    String rand = toppingNames[int(random(toppingNames.length))];
    if (!displaytoppingslist.contains(rand)) {
      displaytoppingslist.add(rand);
    }
  }
}

void showHearts() {

  for (int j = 0; j < 5; j++) {
    PImage heart;
    if (j< livesLeft) {
      heart =  loadImage("heart.png");
    } else {
      heart =  loadImage("heartbreak.png");
    }
    heart.resize(20, 20);
    image( heart, width - width/5 + j*25, 100 );
  }
}
