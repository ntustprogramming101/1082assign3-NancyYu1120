final int GAME_START = 0, GAME_RUN = 1, GAME_OVER = 2;
int gameState = 0;

final int GRASS_HEIGHT = 15;
final int START_BUTTON_W = 144;
final int START_BUTTON_H = 60;
final int START_BUTTON_X = 248;
final int START_BUTTON_Y = 360;
final int lifeX=10, lifeY=10, lifeD=20;

PImage title, gameover, startNormal, startHovered, restartNormal, restartHovered;
PImage bg, life, stone1, stone2;
PImage groundhogIdleImg, groundhogDownImg, groundhogLeftImg, groundhogRightImg;
PImage [] soilImg = new PImage[6];

int groundhogX = 80*4, groundhogY = 80;

// For debug function; DO NOT edit or remove this!
int playerHealth = 0;
float cameraOffsetY = 0;
boolean debugMode = false;

void setup() {
  size(640, 480, P2D);
  // Enter your setup code here (please put loadImage() here or your game will lag like crazy)
  bg = loadImage("img/bg.jpg");
  title = loadImage("img/title.jpg");
  gameover = loadImage("img/gameover.jpg");
  startNormal = loadImage("img/startNormal.png");
  startHovered = loadImage("img/startHovered.png");
  restartNormal = loadImage("img/restartNormal.png");
  restartHovered = loadImage("img/restartHovered.png");
  life = loadImage("img/life.png");
  stone1 = loadImage("img/stone1.png");
  stone2 = loadImage("img/stone2.png");
  for (int i = 0; i <6; i++) {
    soilImg[i] = loadImage("img/soil"+i+".png");
  }
  // groundhog
  groundhogIdleImg = loadImage("img/groundhogIdle.png");
  groundhogDownImg = loadImage("img/groundhogDown.png");
  groundhogLeftImg = loadImage("img/groundhogLeft.png");
  groundhogRightImg = loadImage("img/groundhogRight.png");
}

void draw() {
  /* ------ Debug Function ------ 
   
   Please DO NOT edit the code here.
   It's for reviewing other requirements when you fail to complete the camera moving requirement.
   
   */
  if (debugMode) {
    pushMatrix();
    translate(0, cameraOffsetY);
  }
  /* ------ End of Debug Function ------ */


  switch (gameState) {

  case GAME_START: // Start Screen
    image(title, 0, 0);

    if (START_BUTTON_X + START_BUTTON_W > mouseX
      && START_BUTTON_X < mouseX
      && START_BUTTON_Y + START_BUTTON_H > mouseY
      && START_BUTTON_Y < mouseY) {

      image(startHovered, START_BUTTON_X, START_BUTTON_Y);
      if (mousePressed) {
        gameState = GAME_RUN;
        mousePressed = false;
      }
    } else {

      image(startNormal, START_BUTTON_X, START_BUTTON_Y);
    }
    break;

  case GAME_RUN: // In-Game

    // Background
    image(bg, 0, 0);

    // Sun
    stroke(255, 255, 0);
    strokeWeight(5);
    fill(253, 184, 19);
    ellipse(590, 50, 120, 120);

    // Grass
    fill(124, 204, 25);
    noStroke();
    rect(0, 160 - GRASS_HEIGHT, width, GRASS_HEIGHT);


    // Soil - REPLACE THIS PART WITH YOUR LOOP CODE!
    for (int row=0; row<24; row++) {
      int soilN = floor(row/4);
      for (int col=0; col<8; col++) {
        image(soilImg[soilN], 0+col*soilImg[soilN].width, 160+row*soilImg[soilN].height);
      }
      if (row <8) {
        image(stone1, 0+row*stone1.width, 160+row*stone1.height);
      } else if (row <16) {
        if ( row%4 == 0 || row%4 == 3) {
          image(stone1, 0+1*stone1.width, 160+row*stone1.height);
          image(stone1, 0+2*stone1.width, 160+row*stone1.height);
          image(stone1, 0+5*stone1.width, 160+row*stone1.height);
          image(stone1, 0+6*stone1.width, 160+row*stone1.height);
        } else {
          image(stone1, 0+0*stone1.width, 160+row*stone1.height);
          image(stone1, 0+3*stone1.width, 160+row*stone1.height);
          image(stone1, 0+4*stone1.width, 160+row*stone1.height);
          image(stone1, 0+7*stone1.width, 160+row*stone1.height);
        }
      } else {
        int noStone = (9-row%8)%3;
        for (int col=0; col<8; col++) {
          if (col%3 !=noStone )
          {
            image(stone1, 0+col*stone1.width, 160+row*stone1.height);
          }
          if (col%3 == (noStone+2)%3 )
          {
            image(stone2, 0+col*stone2.width, 160+row*stone2.height);
          }
        }
      }
    }

    // Player
    image(groundhogIdleImg, groundhogX, groundhogY);

    // Health UI
    for (int i=0; i<playerHealth; i++) { 
      image(life, lifeX+i*(life.width+lifeD), lifeY-cameraOffsetY);
    }
    break;

  case GAME_OVER: // Gameover Screen
    image(gameover, 0, 0);

    if (START_BUTTON_X + START_BUTTON_W > mouseX
      && START_BUTTON_X < mouseX
      && START_BUTTON_Y + START_BUTTON_H > mouseY
      && START_BUTTON_Y < mouseY) {

      image(restartHovered, START_BUTTON_X, START_BUTTON_Y);
      if (mousePressed) {
        gameState = GAME_RUN;
        mousePressed = false;
        // Remember to initialize the game here!
      }
    } else {

      image(restartNormal, START_BUTTON_X, START_BUTTON_Y);
    }
    break;
  }

  // DO NOT REMOVE OR EDIT THE FOLLOWING 3 LINES
  if (debugMode) {
    popMatrix();
  }
}

void keyPressed() {
  // Add your moving input code here

  // DO NOT REMOVE OR EDIT THE FOLLOWING SWITCH/CASES
  switch(key) {
  case 'w':
    debugMode = true;
    cameraOffsetY += 25;
    break;

  case 's':
    debugMode = true;
    if ( cameraOffsetY >  -80*20)
    {
      cameraOffsetY -= 25;
    }

    break;

  case 'a':
    if (playerHealth > 0) playerHealth --;
    break;

  case 'd':
    if (playerHealth < 5) playerHealth ++;
    break;
  }
}

void keyReleased() {
}
