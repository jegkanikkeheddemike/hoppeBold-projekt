PImage img;
ArrayList<bold> boldList = new ArrayList<bold>();
surface jorden;


void setup() {
  boldList.clear();
  img = loadImage ("hoppebold.jpg");
  size(700, 700);
  jorden = new surface();

  for (int i = 0; i < 10; i ++) {
    boldList.add(new bold(i, random(45, width-45), random(50, height-175), random(5, 40)));
  }
}

void draw() {
  clear();
  image(img, 0, 0, 991, 700);
  jorden.tegnSurface();
  for (bold i : boldList) {
    i.applyGrav();
    i.checkEdge();
    i.checkJord();
    i.updateLocation();
    i.tegnSelv();
  }
  checkAllCol();
}

void mousePressed() {
  boldList.add(new bold(boldList.size(), mouseX, mouseY, random(5, 40)));
}

void keyPressed() {
  if (key == ' ') {
    setup();
  }
}
