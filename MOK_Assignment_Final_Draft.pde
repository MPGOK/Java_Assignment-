float ballX = 200;
float ballY = 200;
float xSpeed = 3;
float ySpeed = 3;
int ballColour;
int blackSquareColour; // Variable to store the colour of black squares
int blackCircleColour; // // Variable to store the colour of black circles
float ballDiameter = 50; // Starting ball diameter
boolean ballStopped = false; // Flag to track if the ball is stopped
String topText = " Mark O'Keeffe  ";
String bottomText = "Student No. W20002374";

void setup() {
  size(400, 400);
  surface.setLocation(0, 0);
  ballColour = color(255, 0, 0); // Initial ball colour
  blackSquareColour = color(0, 0, 0); // Start with black colour for squares
}

void draw() {
  background(255); // Set background to white

  // Draw checkerboard with changing black square colour
  for (int row = 0; row < 8; row++) {
    for (int col = 0; col < 8; col++) {
      if ((row + col) % 2 == 0) {
        fill(blackSquareColour); // Use changing colour for black squares
      } else {
        fill(255); // White squares remain unchanged
      }
      drawRect(col * 50, row * 50); // Draw the square

      // Adding an additional nested loop to draw circles within white squares
      if ((row + col) % 2 != 0) { // Check if the square is white
        for (int i = 0; i < 1; i++) { // Single circle
          // Draw a circle inside the white square
          fill(blackCircleColour);
        }
        drawBackgroundCircle (col * 50 + 25, row * 50 + 25); //Draw Circle centered in the white square
      }
    }
  }


  // Draw the ball
  fill(ballColour);
  bouncingBall(ballX, ballY, ballDiameter);

  if (ballStopped == false) {
    // Move the ball and check if it hits a wall
    moveCircle();
    frameCircle();
  }

  // Adding the text over the animation
  fill(100); // Grey text
  textSize(40); // Text size
  textAlign(CENTER, CENTER);
  text(topText, width / 2, 30); // Top of the screen text
  text(bottomText, width / 2, 370); // Bottom of the screen text
  trim(topText);
}

void drawRect(float x, float y) { // Draw method for square in background
  rect(x, y, 50, 50);
}

void drawBackgroundCircle(float x, float y) { // Draw method for circle in background
  circle(x, y, 30);
}

void moveCircle() { // Move method for ball
  ballX += xSpeed;
  ballY += ySpeed;
}

void frameCircle() { // Method to set the boundaries of and random direction and speed
  boolean hitWall = false; // Track if the ball hits a wall

  if (ballX > width - ballDiameter / 2 || ballX < ballDiameter / 2) { // Left/Right walls
    xSpeed = random(2, 5);

    if (random(1) > 0.5) {
      xSpeed *=1;
    } else {
      xSpeed *= -1;
    }
    ballX = constrain(ballX, ballDiameter / 2, width - ballDiameter / 2); // Keep inside bounds
    hitWall = true;
  }

  if (ballY > height - ballDiameter / 2 || ballY < ballDiameter / 2) { // Top/Bottom walls
    ySpeed = random(2, 5); // Generate a random speed between 2 and 5

    if (random(1) > 0.5) {
      ySpeed *= 1; // Keep speed positive
    } else {
      ySpeed *= -1; // Make speed negative
    }
    ballY = constrain(ballY, ballDiameter / 2, height - ballDiameter / 2); // Keep inside bounds
    hitWall = true;
  }

  // Change colour if the ball hits a wall
  if (hitWall) {
    ballColour = color(random(0, 255), random(0, 255), random(0, 255)); // Random ball colour
    changeBlackSquareColour(); // Change colour of black squares
    changeBlackCircleColour(); // Changes colour of black cicles
  }
}

// Function to change the colour of black squares
void changeBlackSquareColour() {
  float randomColour = random(3); // Randomly choose one of 3 colours (0, 1, 2)

  if (randomColour == 0) {
    blackSquareColour = color(random(0, 255), 0, random(0, 255));
  } else if (randomColour == 1) {
    blackSquareColour = color(random(0, 255), random(0, 255), 0);
  } else {
    blackSquareColour = color(0, random(0, 255), random(0, 255));
  }
}


// Function to change the colour of black circles
void changeBlackCircleColour() {
  float randomColour = random(3); // Randomly choose one of 3 colours (0, 1, 2)

  if (randomColour == 0) {
    blackCircleColour = color(random(0, 255), random(0, 255), 0); //
  } else if (randomColour == 1) {
    blackCircleColour = color(random(0, 255), 0, random(0, 255));  //
  } else {
    blackCircleColour = color(0, random(0, 255), random(0, 255)); //
  }
}


// Detect mouse click actions to adjust ball size or stop ball
void mousePressed() {
  if (mouseButton == LEFT || mouseButton == RIGHT) {
    float newSize = 0;

    if (mouseButton == LEFT) {
      newSize = ballDiameter +20;
    } else if (mouseButton ==RIGHT) {
      newSize = ballDiameter - 20;
    }

    while (ballDiameter != newSize) {
      while (ballDiameter < newSize && mouseButton ==LEFT) {
        ballDiameter += 1;// Increase ball size
      }
      while (ballDiameter > newSize && ballDiameter > 10) {
        ballDiameter -= 1;// Decrease ball size
      }
    }
  } else if (mouseButton == CENTER) {
    ballStopped = true; // Stop the ball
  }
}

// Detect mouse release action to restore ball size and resume movement
void mouseReleased() {
  if (mouseButton == CENTER) {
    ballStopped = false; // Resume the ball movement
    ballDiameter = 50; // Reset the ball size to original
  }
}

void bouncingBall(float x, float y, float z) {
  circle(x, y, z);
}
