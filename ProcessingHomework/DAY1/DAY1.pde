int N=15;
float r=200;
float a=20;

void setup() {
  size(800, 600);
  background(155);
  noFill();
  stroke(80, 225, 10);
  strokeWeight(2);
}

void draw() {
  translate(width/2, height/2);
  for (int i=0; i<N; i++) {
    ellipse(r/2-a, 0, r, r);
    rotate(2*PI/N);
  }
}