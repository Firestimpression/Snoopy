import processing.serial.*;
Serial myPort;  
int sensorValue;
float xb, yb, vx=0, vy=2, speed=7;
int combo=0, score=0, goodgame=0;
float boardlength=600;
float []brickx=new float[100];
float []bricky=new float[100];
float []brickalpha=new float[100];

void setup()
{
  smooth();
  fullScreen();
  myPort = new Serial(this, "COM3", 9600);

  xb=width/2;
  yb=height-200;
  for (int i=1; i<=30; i++)
  {
    brickx[i]=random(40, width-40);
    bricky[i]=random(20, height/2);
    brickalpha[i]=250;
  }
  noCursor();
  textSize(50);
  noStroke();
  frameRate(120);
}
void draw()
{
  background(255);
  fill(0, 0, 0, 225);
  rect(mouseX-boardlength/2, height-40, boardlength, 40);
  if (abs(yb-(height-60))<speed)
    if (abs(xb-mouseX)<boardlength/2)
    {
      vx+=(pmouseX-mouseX)/3;
      vy=-speed;
      combo=0;
    }
  xb+=vx;
  yb+=vy;

  for (int i=1; i<=30; i++)
  {
    if ((abs(xb-brickx[i])<60)&(abs(yb-bricky[i])<40))
    {
      if (xb<brickx[i])
        if ((yb>bricky[i]+20)||(yb<bricky[i]-20)) vy=-vy;
        else vx=-vx;

      if (xb>brickx[i])
        if ((yb>bricky[i]+20)||(yb<bricky[i]-20)) vy=-vy;
        else vx=-vx;
      brickalpha[i]-=125;
      if (brickalpha[i]<=0)
      {
        bricky[i]=-2000;
        brickx[i]=-2000;
      }
      combo++;
      score+=10*combo;
    }
    if (brickx[i]>-1)
      fill(brickx[i]%255, bricky[i]%255, (brickx[i]*bricky[i])%255, brickalpha[i]);
    rect(brickx[i]-40, bricky[i]-20, 80, 40);
  }
  if ((xb>width-20)||(xb<20))
    vx=-vx;
  if (yb<20)
    vy=-vy;
  if (yb>height-20)
  {
    myPort.write(0);
    noLoop();
  }
  goodgame=1;
  for (int i=1; i<=30; i++)
    if (brickx[i]!=-2000) goodgame=0;
  if (goodgame==1)
  {
    myPort.write(1);
    noLoop();
  }
  text(score+" Score", 20, height-180);
  text(combo+" Combo", 20, height-80);
  fill(random(0, 225), random(0, 225), random(0, 225));
  ellipse(xb, yb, 40, 40);
}