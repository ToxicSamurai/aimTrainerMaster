//ToxicSamurai
//Licensed under Creative Commons CC-BY-NC-SA

//Floats for x and y positions
float posX, posY;
//Floats for random integers used for random movement
float randInt, randRandInt;
//Integer used for keeping score
int score;
//Integers used for moving the x and y position variables
int speedX = 3, speedY = 3;
//Integers used for filling shapes
int fillR = 255, fillG = 0, fillB = 0, bgR = 255, bgGB = 255;
//Integers used for timing
int ms = 0, msSpeed = 1;
//Boolean for difficulty menu
boolean begin = false;

public void setup(){
  size(800, 800);
  textSize(25);
  //Sets floats after creating canvas
  posX = width/2 - 25;
  posY = height/2 - 25;
}

public void draw(){
  //Checks is a difficulty has been selected
  //If not:
  if(begin == false){
    background(255);
    starterShapes();
  }
  //If so:
  if(begin == true){
    //Randomized distractions for hard diff are found in move();, which is why it is above background
    move();
    background(bgR, bgGB, bgGB);
    shapes();
    scoreDetect();
    scoreCounter();
    timer();
    //Resets color variables
    bgR = 255;
    bgGB = 255;
    fillR = 255;
    fillG = 0;
    fillB = 0;
  }
}

//Creates buttons and text for difficulty menu
void starterShapes(){
  //Easy button
  fill(0, 255, 0);
  rect(width/6, height/3, 200, 100);
  fill(0);
  text("Easy", width/6 + 75, height/3 + 60);
  //Medium button
  fill(255, 255, 0);
  rect(width/6, height/2, 200, 100);
  fill(0);
  text("Medium", width/6 + 55, height/2 + 60);
  //Hard button
  fill(255, 0, 0);
  rect(width/6, 2 * (height/3), 200, 100);
  fill(0);
  text("Hard", width/6 + 75, 2 * (height/3) + 57.5);
}

//Creates target and the line
void shapes(){
  //Square target
  fill(fillR, fillG, fillB);
  rect(posX, posY, 50, 50);
  //Score line divider
  fill(255, 0, 0);
  line(width-width, (height-height)+50, width, (height-height)+50);
}

//Detects if the mouse is on the target and increases score
void scoreDetect(){
  if(mouseX >= posX && mouseX <= posX + 50){
    if(mouseY >= posY && mouseY <= posY + 50){
      //One point per frame
      score ++;
    }
  }
}

//Controls the movement and random distractions on hard diff
void move(){
  //Random movement calculation
  randInt = random(randRandInt);
  if(randInt >= 40 && randInt <= 60){
    speedX = speedX * -1;
  }
  if(randInt >= 80 && randInt <= 100){
    speedY = speedY * -1;
  }
  
  //Pulls the target back if it tries to leave the play area
  if(posX >= 700 || posX <= 0){
    speedX = speedX * -1;
  }
  
  if(posY >= 700 || posY <= 100){
    speedY = speedY * -1;
  }
  
  //Random distractions calculation
  if(randRandInt == 1000 && randInt >= 0 && randInt <= 10){
    bgR = 255;
    bgGB = 0;
    
    fillR = 0;
    fillG = 226;
    fillB = 229;
  }
  
  //Moves the target
  posX = posX + speedX;
  posY = posY + speedY;
}

//Counts the score
void scoreCounter(){
  text("Score: " + score, 50, 25);
}

//Counts the time to 1000 points
void timer(){
 if(score <= 1000){
   //Only increases if the score is below or equal to 1000
   ms = ms + msSpeed;
 }
 else if(score > 1000){
    //Shows the time to reach 1000 frames when 1000 is reached
    fill(255, 0, 0);
    text("Time to reach 1000: " + ms + " frames", 300, 25);
  }
}

//Detection for pressing a difficulty button
void mousePressed(){
  if(begin == false){
    //Easy
    if(mouseX >= width/6 && mouseX <= width/6 + 200){
      if(mouseY >= height/3 && mouseY <= height/3 + 100){
        begin = true;
        randRandInt = 3000;
      }
    }
    //Medium
    if(mouseX >= width/6 && mouseX <= width/6 + 200){
      if(mouseY >= height/2 && mouseY <= height/2 + 100){
        begin = true;
        randRandInt = 2000;
      }
    }
    //Hard
    if(mouseX >= width/6 && mouseX <= width/6 + 200){
      if(mouseY >= 2 * (height/3) && mouseY <= 2 * (height/3) + 100){
        begin = true;
        randRandInt = 1000;
      }
    }
  }
}
