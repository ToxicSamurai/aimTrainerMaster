//ToxicSamurai
//You may use, but not edit or infringe my code

float posX;
float posY;
int ms, lastTime, lastTimeHolder, bestTime, score;
int lastTimeActual = 99999; 

public void setup(){
  size(800, 800);
  textSize(25);
  posX = width/2-25;
  posY = height/2-25;
}

public void draw(){
  background(255);
  shapes();
  timer();
  numcheck();
}

void shapes(){
  fill(255, 0, 0);
  rect(posX, posY, 50, 50);
  line(width-width, height-50, width, height-50);
  line(width-width, (height-height)+50, width, (height-height)+50);
}

void timer(){
  ms ++;
  text("Time: " + ms + " frames", 50, 785);
  text("Last time: " + lastTime + " frames", 275, 785);
  text("Best time: " + bestTime + " frames", 550, 785);
  text("Score: " + score, 50, 25);
}

void numcheck(){
  println("posX + posY", posX, "+", posY);
  println("mouseX + mouseY", mouseX, "+", mouseY);
}

void mousePressed(){
  if(mouseX >= posX && mouseX <= posX + 50){
    if(mouseY >= posY && mouseY <= posY + 50){
      posX = random(0, 700);
      posY = random(50, 700);
      lastTimeHolder = ms;
      timeCheck();
      lastTime = ms;
      ms = 0;
      score = score + 1;
    }
  }
}

void timeCheck(){
  if(lastTimeActual <= lastTimeHolder){
    bestTime = lastTimeActual;
  }
  else{
    lastTimeActual = lastTimeHolder;
  }
}
