int N=15;
float r=200;
float a=20;


void setup() {
  size(800, 600);
  background(155);
  noFill();
}

void draw() {
  if (mousePressed) {
    stroke(random(0,255),random(0,255),random(0,255));
    strokeWeight(2);
  }
  translate(width/2, height/2);
  for (int i=0; i<N; i++) {
    ellipse(r/2-a, 0, r, r);
    rotate(2*PI/N);
  }
}