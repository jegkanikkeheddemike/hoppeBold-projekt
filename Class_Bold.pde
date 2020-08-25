void checkAllCol() {
  for (bold i : boldList) {
    if (i.hasBouncedThisTurn) {
      continue;
    }
    for (bold j : boldList) {
      if (i == j || j.hasBouncedThisTurn || i.hasBouncedThisTurn) {
        continue;
      }

      if (dist(j.loc.x+j.vel.x, j.loc.y+j.vel.y, i.loc.x+i.vel.x, i.loc.y+i.vel.x) < i.mass/2 + j.mass/2) {
        reactCol(i, j);
        i.hasBouncedThisTurn = true;
        j.hasBouncedThisTurn = true;
      }
    }
  }
  for (bold i : boldList) {
    i.hasBouncedThisTurn = false;
  }
}

void reactCol(bold i, bold j) {
  i.changeCol();
  j.changeCol();
  float angle = atan2((j.loc.y-i.loc.y), (j.loc.x-i.loc.x));
  float jMag = j.vel.mag();
  float iMag = i.vel.mag();

  j.vel = PVector.fromAngle(angle);
  j.vel.mult(jMag);

  i.vel = PVector.fromAngle(angle+PI);
  i.vel.mult(iMag);
}

class bold {
  PVector force = new PVector();
  PVector loc = new PVector();
  PVector vel = new PVector();
  float mass;
  color col;
  int ID;
  boolean hasBouncedThisTurn = false;

  void changeCol() {
    col = color(random(100, 255), random(100, 255), random(100, 255));
  }

  void applyGrav() {
    vel.add(0, 0.1);
  }


  void checkJord() {
    if (loc.y >= jorden.findOverfaldeVedX(loc.x)) {
      reagerJord();
    }
  }

  void reagerJord() {
    int arrayPlace = floor(loc.x / jorden.punktBredde);
    PVector vSurface = new PVector(jorden.punktBredde, jorden.overflade[arrayPlace] - jorden.overflade[arrayPlace+1]);

    float angle = atan2(vSurface.y, vSurface.x);
    //float vAngle = atan2(vel.y,vel.x);
    float vLength = vel.mag();
    vel = PVector.fromAngle(-angle-PI/2);
    vel.mult(vLength);
  }

  void tegnSelv() {
    stroke(0);
    fill(col);
    ellipse(loc.x, loc.y, mass, mass);
  }

  void updateLocation() {
    force.div(mass);
    vel.add(force);
    force.mult(0);
    loc.add(vel);
  }

  void checkEdge() {
    if (loc.x + mass/2 + vel.x>= width) {
      loc.x = width-mass/2;
      vel.x *= -1;
      changeCol();
    }
    if (loc.y + mass/2 + vel.y>= height) {
      loc.y = height-mass/2;
      changeCol();
      vel.y *= -1;
    }
    if (loc.x - mass/2 + vel.x <= 0) {
      loc.x = 0+mass/2;
      vel.x *= -1;
      changeCol();
    }
    if (loc.y - mass/2 + vel.y <= 0) {
      loc.y = 0+mass/2;
      vel.y *= -1;
      changeCol();
    }
  }

  bold(int getID, float getX, float getY, float getMass) {
    this.ID = getID;
    this.loc.x = getX;
    this.loc.y = getY;
    this.mass = getMass;
    this.vel.x = random(-40, 40);
    this.vel.y = random(-40, 40);
    this.vel.div(this.mass);
    this.changeCol();
  }
}
