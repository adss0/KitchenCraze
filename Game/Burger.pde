class Burger extends Food
{
  //Constructor with the same properties as the superclass
  Burger(PImage FoodImage, float SpeedX, float SpeedY, float FoodX, float FoodY, float FoodDimensions)
  {
    super(FoodImage, SpeedX, SpeedY,  FoodX, FoodY,FoodDimensions);
  }
    @Override
    void display() {
        // Move the burger diagonally
        FoodX -= SpeedX/1.8;  // Move horizontally
        FoodY += SpeedY*1.8;  // Move vertically

        // Display the burger at its new position
        image(FoodImage, FoodX, FoodY, FoodDimensions, FoodDimensions);
    }
}
