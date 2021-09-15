//By ToxicSamurai
//A combination of my other two aim training games into one game

//You may use, but not edit/infringe upon my code

//Game1 variables
//Booleans for time andscore except I didn't fucking comment
//when I made it so I have no idea what it actually does
int ms1, lastTime, lastTimeHolder, bestTime, score1;
int lastTimeActual = 99999;
//Floats for x and y positions for game 1
float posX1, posY1;

//Game2 variables
//Floats for x and y positions for game 2
float posX2, posY2;
//Floats for random integers used for random movement
float randInt, randRandInt;
//Integer used for keeping score
int score2;
//Integers used for moving the x and y position variables
int speedX = 3, speedY = 3;
//Integers used for filling shapes
int fillR = 255, fillG = 0, fillB = 0, bgR = 255, bgGB = 255;
//Integers used for timing
int ms2 = 0, msSpeed = 1;
//Boolean for difficulty menu
boolean begin = false;

//Master variables
//Boolean for choosing game mode
boolean menu = true;
//Integer for choosing gamemode
int gameMode = 0;

//Master setup
public void setup() {
  size(800, 800);
  textSize(25);
  //Sets floats after creating canvas
  posX1 = width/2 - 25;
  posY1 = height/2 - 25;
  posX2 = width/2 - 25;
  posY2 = height/2 - 25;
}

//Game 1 draw
public void draw() {
  background(255);

  //Checks if a gamemode has been selected
  menuCheck();

  //If gamemode == 1, play aimTrainer
  if (gameMode == 1) {
    shapesGame1();
    numcheck();
    mousePressedCheckGame1();
    timerGame1();
  }

  //If gamemode == 2, play aimTrainerTracer
  if (gameMode == 2) {
    //Checks is a difficulty has been selected
    //If not:
    if (begin == false) {
      background(255);
      starterShapes();
      mousePressedCheckGame2();
    }
    //If so:
    if (begin == true) {
      //Randomized distractions for hard diff are found in move();, which is why it is above background
      move();
      background(bgR, bgGB, bgGB);
      shapesGame2();
      scoreDetect();
      scoreCounter();
      timerGame2();
      //Resets color variables
      bgR = 255;
      bgGB = 255;
      fillR = 255;
      fillG = 0;
      fillB = 0;
    }
  }
}

//Function to check if a gamemode has been selected yet
void menuCheck() {
  if (menu == true && gameMode == 0) {
    background(255);
    fill(255, 0, 0);
    rect(width/6-50, height/2-50, 200, 100);
    fill(0);
    text("Aim Trainer", width/6-20, height/2+10);
    textSize(48);
    text("Scarlett's Aim", width/2-150, height/6);
    text("Trainer", width/2-75, height/6+52);
    textSize(25);

    if (mouseX>width/6-50 && mouseX<width/6+150 && mouseY>height/2-50 && mouseY<height/2+50) {
      println("win");
      if (mousePressed) {
        menu = false;
        gameMode = 1;
      }
    }

    fill(0, 0, 255);
    rect(4*(width/6), height/2-50, 200, 100);
    fill(0);
    text("Aim Trainer Tracer", 4*(width/6)+35, height/2-32.5, 200, 100);
    if (mouseX>4*(width/6) && mouseX<4*(width/6)+200 && mouseY>height/2-50 && mouseY<height/2+50) {
      println("win");
      if (mousePressed) {
        menu = false;
        gameMode = 2;
      }
    }
  }
}

// GAME 1 (aimTrainer)

void shapesGame1() {
  fill(255, 0, 0);
  rect(posX1, posY1, 50, 50);
  line(width-width, height-50, width, height-50);
  line(width-width, (height-height)+50, width, (height-height)+50);
}

void timerGame1() {
  ms1 ++;
  text("Time: " + ms1 + " frames", 50, 785);
  text("Last time: " + lastTime + " frames", 275, 785);
  text("Best time: " + bestTime + " frames", 550, 785);
  text("Score: " + score1, 50, 35);
}

void numcheck() {
  println("posX1 + posY1", posX1, "+", posY1);
  println("mouseX + mouseY", mouseX, "+", mouseY);
}

void mousePressedCheckGame1() {
  if (gameMode == 1) {
    if (mouseX >= posX1 && mouseX <= posX1 + 50) {
      if (mouseY >= posY1 && mouseY <= posY1 + 50) {
        if (mousePressed) {
          posX1 = random(0, 700);
          posY1 = random(50, 700);
          lastTimeHolder = ms1;
          timeCheck();
          lastTime = ms1;
          ms1 = 0;
          score1 = score1 + 1;
        }
      }
    }
  }
}

void timeCheck() {
  if (lastTimeActual <= lastTimeHolder) {
    bestTime = lastTimeActual;
  } else {
    lastTimeActual = lastTimeHolder;
  }
}

//END GAME 1

/*----------------------------------------------------------------------*/


//GAME 2 (aimTrainerTracer)

//Creates buttons and text for difficulty menu
void starterShapes() {
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
  //Title
  textSize(32);
  text("Aim Trainer (Tracer)", width/2-150, height/6);
  textSize(25);
}

//Creates target and the line
void shapesGame2() {
  //Square target
  fill(fillR, fillG, fillB);
  rect(posX2, posY2, 50, 50);
  //Score line divider
  fill(255, 0, 0);
  line(width-width, (height-height)+50, width, (height-height)+50);
}

//Detects if the mouse is on the target and increases score
void scoreDetect() {
  if (mouseX >= posX2 && mouseX <= posX2 + 50) {
    if (mouseY >= posY2 && mouseY <= posY2 + 50) {
      //One point per frame
      score2 ++;
    }
  }
}

//Controls the movement and random distractions on hard diff
void move() {
  //Random movement calculation
  randInt = random(randRandInt);
  if (randInt >= 40 && randInt <= 60) {
    speedX = speedX * -1;
  }
  if (randInt >= 80 && randInt <= 100) {
    speedY = speedY * -1;
  }

  //Pulls the target back if it tries to leave the play area
  if (posX2 >= 700 || posX2 <= 0) {
    speedX = speedX * -1;
  }

  if (posY2 >= 700 || posY2 <= 100) {
    speedY = speedY * -1;
  }

  //Random distractions calculation
  if (randRandInt == 1000 && randInt >= 0 && randInt <= 10) {
    bgR = 255;
    bgGB = 0;

    fillR = 0;
    fillG = 226;
    fillB = 229;
  }

  //Moves the target
  posX2 = posX2 + speedX;
  posY2 = posY2 + speedY;
}

//Counts the score
void scoreCounter() {
  text("Score: " + score2, 50, 35);
}

//Counts the time to 1000 points
void timerGame2() {
  if (score2 <= 1000) {
    //Only increases if the score is below or equal to 1000
    ms2 = ms2 + msSpeed;
  } else if (score2 > 1000) {
    //Shows the time to reach 1000 frames when 1000 is reached
    fill(255, 0, 0);
    text("Time to reach 1000: " + ms2 + " frames", 300, 35);
  }
}

//Detection for pressing a difficulty button
void mousePressedCheckGame2() {
  if (gameMode == 2) {
    if (begin == false) {
      //Easy
      if (mouseX >= width/6 && mouseX <= width/6 + 200) {
        if (mouseY >= height/3 && mouseY <= height/3 + 100) {
          if (mousePressed) {
            begin = true;
            randRandInt = 3000;
          }
        }
      }
      //Medium
      if (mouseX >= width/6 && mouseX <= width/6 + 200) {
        if (mouseY >= height/2 && mouseY <= height/2 + 100) {
          if (mousePressed) {
            begin = true;
            randRandInt = 2000;
          }
        }
      }
      //Hard
      if (mouseX >= width/6 && mouseX <= width/6 + 200) {
        if (mouseY >= 2 * (height/3) && mouseY <= 2 * (height/3) + 100) {
          if (mousePressed) {
            begin = true;
            randRandInt = 1000;
          }
        }
      }
    }
  }
}

//END GAME 2
