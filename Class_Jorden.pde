class surface {
  float[] overflade = new float[11];
  float punktBredde;
  surface() {
    for (int i=0; i < overflade.length; i ++) {
      overflade[i] = random(height-150, height-50);
    }
    println(overflade);
    punktBredde = width / (overflade.length-1);
  }

  void tegnSurface () {
    
    for (int i = 0; i < overflade.length-1; i ++) {
      stroke(255);
      line(i*punktBredde, overflade[i], (i+1)*punktBredde, overflade[i+1] );
      stroke(255, 0, 0);
    }
  }

  float findOverfaldeVedX(float checkX) {
    float sendX = 0;
    int arrayPlace = floor(checkX / punktBredde);
    float relX = checkX-arrayPlace*punktBredde;
    float angle = (overflade[arrayPlace] - overflade[arrayPlace+1])/punktBredde;

    sendX = overflade[arrayPlace]-angle*relX;
    return sendX;
  }
}
