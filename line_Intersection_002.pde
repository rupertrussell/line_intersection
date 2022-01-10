// Test for line intersection only draw up to intersection point
// Rupert Russell September 10 2020
// Thnks to REAS https://www.openprocessing.org/sketch/8002#
int Width = 400;
int Height = 400;
boolean intersect = false;
float x, y; // used to hold intersection point


// Declare and construct two objects (L1 and L2) of the class myLine
myLine L1 = new myLine(0, 0, Width, Height);
myLine L2 = new myLine(Width, 0, 0, Height);

void setup() {
  size(400, 400);
  noFill();
}

void draw() {
  background(200);
  L2.endX = mouseX;
  L2.endY = mouseY;

  L1.update();  // Calls the L1 object's update() function
  L2.update();  // Calls the L2 object's update() function

  //  intersect = lineLineIntersect(L1.startX, L1.startY, L1.endX, L1.endY, L2.startX, L2.startY, L2.endX, L2.endY );
}
class myLine {  // Class definition
  float startX, startY, endX, endY;  // Local variables

  myLine (float x1, float y1, float x2, float y2) {  // Object constructor
    startX = x1;
    startY = y1;
    endX = x2;
    endY = y2;
  }

  void update() {  // Update method

    intersect = lineLineIntersect(L1.startX, L1.startY, L1.endX, L1.endY, L2.startX, L2.startY, L2.endX, L2.endY );

    if (intersect == false) {
      line(startX, startY, endX, endY);
    } else {
      line(L1.startX, L1.startY, L1.endX, L1.endY);
      line(L2.startX, L2.startY, x, y);
      ellipse(x, y, 15, 15);
    }
  }

  boolean lineLineIntersect(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4 ) {
    boolean intersect = false;
    float a1 = y2 - y1;
    float b1 = x1 - x2;
    float c1 = a1*x1 + b1*y1;

    float a2 = y4 - y3;
    float b2 = x3 - x4;
    float c2 = a2*x3 + b2*y3;

    float det = a1*b2 - a2*b1;
    if (det == 0) {
      // Lines are parallel
    } else {
      x = (b2*c1 - b1*c2)/det;
      y = (a1*c2 - a2*c1)/det;
      if (x > min(x1, x2) && x < max(x1, x2) && 
        x > min(x3, x4) && x < max(x3, x4) &&
        y > min(y1, y2) && y < max(y1, y2) &&
        y > min(y3, y4) && y < max(y3, y4)) {
        intersect = true;
      }
    }
    return intersect;
  }
}

void mouseClicked() {
 save("line_intersection_002.png");
 exit();
}
