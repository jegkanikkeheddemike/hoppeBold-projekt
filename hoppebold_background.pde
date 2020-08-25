PImage img;
void setup() {
  size (700,700);
  img = loadImage ("hoppebold.jpg");
}

void draw() {
  background(0);
  image(img,0,0);
}
