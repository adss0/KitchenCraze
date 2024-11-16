// abstract class to serve as baseclass for other food items.
abstract class Food
{
  float FoodX;   //x coordinates of food
  float FoodY;   //y coordinates of food
  float InitialFoodX;
  float InitialFoodY;
  float FoodDimensions;  //size of the foood image
  float SpeedX;
  float SpeedY;
  PImage FoodImage;  // food image
//Constructor
  Food(PImage FoodImage, float SpeedX, float SpeedY, float FoodX, float FoodY, float FoodDimensions)
  {
    this.FoodImage = FoodImage;
    this.SpeedX = SpeedX;
    this.SpeedY = SpeedY;
    this.FoodX= FoodX;
    this.FoodY=FoodY;
    this.InitialFoodX=FoodX; 
    this.InitialFoodY=FoodY;  

    this.FoodDimensions=FoodDimensions;
  }

  void resetfood()
  {
    FoodX=InitialFoodX; //reset the item to its original x value that was passed in the constructor
    FoodY=InitialFoodY; //reset the item to its original Y value that was passed in the constructor
  }

  void display() {
    //Conditions to move the image across the screen
    if ( FoodY<=305) {
      FoodX=FoodX - SpeedX;
      FoodY=FoodY+SpeedY;
    } else if (FoodY>=305 && FoodY<=600) {
      FoodX=FoodX+SpeedX;
      FoodY=FoodY+SpeedY*2;
    } else if ( FoodY>=600) {
      FoodX=FoodX-SpeedX;
    }
    //initalize the FoodImage at the coordinates and resize it
    image(FoodImage, FoodX, FoodY, FoodDimensions, FoodDimensions);
  }
}
