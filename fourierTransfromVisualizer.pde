int points = 512;
int count = 0;
float[] xWave = new float[points];
float[] yWave1 = new float[points];
float[] yWave2 = new float[points];
float[] yWaveTotal = new float[points];
float[] time = new float[points];
float[] xCurved = new float[points];
float[] yCurved = new float[points];
float[] alpha = new float[points];
FloatList xMassList = new FloatList();
FloatList yMassList = new FloatList();
FloatList curvedFrequencyList = new FloatList();
float totalTime = 3;
float a1;
float a2;
float aTotal;
float waveFrequency1;
float waveFrequency2;
float curvedFrequency;
float spaceLines;
float sumX;
float sumY;
float xMass;
float yMass;
float displayCoeff;

void setup(){
  fullScreen();
  frameRate(120);
  a1 = height/8;
  a2 = height/10;
  displayCoeff = 1.2;
  aTotal = a1+a2;
  waveFrequency1 = 2;
  waveFrequency2 = 3;
  curvedFrequency = 1;
  for(int i=0; i<xWave.length; i++){
    if(i==0){
      xWave[i] = 0;
    } else {
      xWave[i] = xWave[i-1]+float(width)/float((2*xWave.length));
    }
    time[i] = 2*totalTime*xWave[i]/width;
    yWave1[i] = a1*cos(waveFrequency1*TWO_PI*time[i]);
    yWave2[i] = a2*cos(waveFrequency2*TWO_PI*time[i]);
    yWaveTotal[i] = yWave1[i]+yWave2[i];
  }
  xMass = 0;
  yMass = 0;
}

void draw(){
  background(243,243,247);
  stroke(150);
  strokeWeight(6);
  line(width/2, 0, width/2, height);
  line(width/2, height/2, width, height/2);

  curvedFrequency += 0.001;
  if(curvedFrequency >= 6){
    noLoop();
  }
  spaceLines = width/(2*totalTime*curvedFrequency);
  for(int i=0; i<xWave.length; i++){
    alpha[i] = curvedFrequency*time[i]*TWO_PI;
    xCurved[i] = (aTotal+yWaveTotal[i])/displayCoeff*cos(alpha[i]);
    yCurved[i] = (aTotal+yWaveTotal[i])/displayCoeff*sin(alpha[i]);
  }
  
  // Wave display
  translate(width/2, height/4);
  noFill();
  stroke(150);
  strokeWeight(6);
  line(0, 0, width/2, 0);
  stroke(119, 150, 203);
  beginShape();
  for(int i=0; i<xWave.length; i++){
    vertex(xWave[i], yWaveTotal[i]);
  }
  endShape();
  stroke(206, 71, 96);
  strokeWeight(6);
  beginShape();
  for(int i=0; i<xWave.length; i++){
    vertex(xWave[i], yWave1[i]);
  }
  endShape();
  stroke(22, 152, 115);
  strokeWeight(6);
  beginShape();
  for(int i=0; i<xWave.length; i++){
    vertex(xWave[i], yWave2[i]);
  }
  endShape();
  translate(-width/2, -height/4);
  
  // Curved display
  noFill();
  stroke(119,150,203);
  strokeWeight(6);
  translate(width/4, height/2);
  beginShape();
  for(int i=0; i<xWave.length; i++){
    vertex(xCurved[i], yCurved[i]);
  }
  endShape();
  translate(-width/4, -height/2);
  
  // Center of mass
  translate(width/4, height/2);
  sumX = 0;
  sumY = 0;
  for(int i=0; i<points; i++){
    sumX += xCurved[i];
    sumY += yCurved[i];
  }
  xMass = sumX/float(points);
  xMassList.append(xMass);
  yMassList.append(yMass);
  curvedFrequencyList.append(curvedFrequency);
  yMass = sumY/float(points);
  stroke(0, 250, 0);
  strokeWeight(6);
  point(3*xMass, 3*yMass);
  stroke(0, 180, 0, 175);
  point(0, 3*yMass);
  point(3*xMass, 0);
  stroke(150);
  strokeWeight(3);
  line(0, 3*yMass, 3*xMass, 3*yMass);
  line(3*xMass, 0, 3*xMass, 3*yMass);
  translate(-width/4, -height/2);
  
  // Information display
  translate(width/2, height/4);
  strokeWeight(6);
  stroke(180, 60);
  for(int i=0; i<float(width)/(2*spaceLines)-1; i++){
    line((i+1)*spaceLines, -height/4, (i+1)*spaceLines, height/4);
  }
  translate(0, height/2);
  strokeWeight(6);
  stroke(180, 90, 90);
  line(0, 0, width/2, 0);
  stroke(119, 150, 203);
  beginShape();
  for(int i=0; i<curvedFrequencyList.size(); i++){
    vertex((curvedFrequencyList.get(i)-1)*width/(2*5), 3*xMassList.get(i));
  }
  endShape();
  stroke(249, 170, 63);
  beginShape();
  for(int i=0; i<curvedFrequencyList.size(); i++){
    vertex((curvedFrequencyList.get(i)-1)*width/(2*5), 3*yMassList.get(i));
  }
  endShape();
  stroke(180, 60);
  line(width/(2*5), -height/4, width/(2*5), height/4);
  line(2*width/(2*5), -height/4, 2*width/(2*5), height/4);
  line(3*width/(2*5), -height/4, 3*width/(2*5), height/4);
  line(4*width/(2*5), -height/4, 4*width/(2*5), height/4);
  text("1", 0.05*width/(2*5), -15);
  textSize(45);
  fill(150);
  text("2", 1.05*width/(2*5), -15);
  text("3", 2.05*width/(2*5), -15);
  text("4", 3.05*width/(2*5), -15);
  text("5", 4.05*width/(2*5), -15);
  text("6", 5.05*width/(2*5), -15);
  translate(-width/2, -3*height/4);
  }
