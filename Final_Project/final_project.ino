int a_data = 0;
int speakerPin = 8;
 
int length = 15; 
char notes[] = "ccggaagffeeddc "; 
int beats[] = { 1, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 1, 2, 4 };
int tempo = 300;
 
void playTone(int tone, int duration) {
  for (long i = 0; i < duration * 1000L; i += tone * 2) {
    digitalWrite(speakerPin, HIGH);
    delayMicroseconds(tone);
    digitalWrite(speakerPin, LOW);
    delayMicroseconds(tone);
  }
}
 
void playNote(char note, int duration) {
  char names[] = { 'c', 'd', 'e', 'f', 'g', 'a', 'b', 'C' };
  int tones[] = { 1915, 1700, 1519, 1432, 1275, 1136, 1014, 956 };
 
  
  for (int i = 0; i < 8; i++) {
    if (names[i] == note) {
      playTone(tones[i], duration);
    }
  }
}
#include <LiquidCrystal.h>

LiquidCrystal lcd(12, 11, 5, 4, 3, 2);



void setup()
{
  lcd.begin(16, 2);
  lcd.print("Welcome!");
  delay(2000);
  lcd.clear();
  lcd.print("Fighting!");
  pinMode(13,OUTPUT);
  pinMode(speakerPin, OUTPUT);
  Serial.begin(9600);

}

void loop()
{
  if (Serial.available() > 0) {
    a_data = Serial.read();
    if (a_data) {
      lcd.clear();
      lcd.setCursor(0, 0);
      lcd.print("Good Game !");
      for (int i = 0; i < length; i++) {
    if (notes[i] == ' ') {
      delay(beats[i] * tempo); 
    } else {
      playNote(notes[i], beats[i] * tempo);
    }
 
    
    delay(tempo / 2); 
  }
    }
    else {
      lcd.clear();
      lcd.setCursor(0, 0);
      lcd.print("Game Over !");
      digitalWrite(13,HIGH);
      
    }
  }
}



