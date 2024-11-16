class Topping {

  float x;
  float y;
  float InitialX;
  float InitialY;
  float ToppingOffset;  //Offset after topping is attached to the food
  int Dimensions;  //size of the image
  int ModNumber = 0;
  int Direction = 1;

  String imageURL;
  boolean ToppingIsResized;
  boolean ToppingIsAttached;
  PImage ToppingImage;

  //Constructor
  Topping(String url, float x, float y, int Dimensions)
  {
    this.x = x;
    this.y = y;
    this.imageURL=url;
    this.Dimensions =Dimensions;
    //Load image from the url
    ToppingImage = loadImage(url);
    //resize image
    ToppingImage.resize(Dimensions, Dimensions);

    this.InitialX=x;
    this.InitialY=y;
    this.ToppingIsResized=false;
    this.ToppingIsAttached=false;
  }

  //Second constructor with an Offset variable
  Topping(String url, float x, float y, int Dimensions, float ToppingOffset) {
    this(url, x, y, Dimensions);
    this.ToppingOffset=ToppingOffset;
  }

  void render() {
    if (ToppingIsResized) {
      ToppingImage.resize(Dimensions/2, Dimensions/2);
    }
    if (!ToppingIsAttached) {
      //animation
      ModNumber += Direction;
      if (ModNumber == 20 || ModNumber == 0) {
        Direction *= -1;
      }
      image(ToppingImage, x, y+ ModNumber);
    } else {
      image(ToppingImage, x, y);
    }
  }
  void reset()
  {
    //Reset topping
    x=InitialX;
    y=InitialY;
    ToppingIsResized=false;
    ToppingIsAttached = false;
    ToppingImage.resize(Dimensions, Dimensions);
  }

  //create a new instance of the topping with a random offset value
  Topping createNewInstance() {
    return new Topping(imageURL, x, y, Dimensions, random(25, 65)); //Second constructor used
  }
}
