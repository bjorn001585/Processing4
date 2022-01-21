int r = 30;
int amount = 10;
int rad = 200;

Item items[] = new Item[amount];

void setup() {
  size(900, 800, P2D);
  noStroke();
  smooth(8);
  
  for(int i = 0; i < amount; i++) {
    int randX = (int)random(r, width - r);
    int randY = (int)random(r, height - r);
    
    items[i] = new Item(randX, randY, r);
    items[i].draw();
  }
}

void draw() {
  background(50);
  
  for(int i = 0; i < items.length; i++) {
    Item data = items[i];
    
    float x = data.posX += data.vx;
    float y = data.posY += data.vy;
    
    if(x < data.R || x > (width - data.R)) data.setVelocity(-data.vx, data.vy);
    if(y < data.R || y > (height - data.R)) data.setVelocity(data.vx, -data.vy);
     
    // lines
    for(int j = 0; j < i; j++) {
      Item dataJ = items[j];
      
      int distantion = (int)dist(data.posX, data.posY, dataJ.posX, dataJ.posY);
      
      stroke(255);
      if(distantion < rad) {
        strokeWeight(map(distantion, 0, rad, 4, 0.5));
        
        line(data.posX, data.posY, dataJ.posX, dataJ.posY);
      }
    }
    
    data.update(data.posX, data.posY);
  }
}

class Item {
  int posX;
  int posY;
  int R;
  color col;
  
  float vx = random(1, 5);
  float vy = random(1, 5);
  
  Item(int posX, int posY, int R) {
    this.posX = posX;
    this.posY = posY;
    this.R = R;
    this.col = color(random(100, 255), random(100, 255), random(100, 255));
  }
  
  Item(int posX, int posY, int R, color col) {
    this.posX = posX;
    this.posY = posY;
    this.R = R;
    this.col = col;
  }
  
  void update(int posX, int posY) {
    this.posX = posX;
    this.posY = posY;
    
    this.draw(posX, posY);
  }
  
  void setVelocity(float x, float y) {
    this.vx = int(x);
    this.vy = int(y);
  }
  
  void draw(int posX, int posY) {
    fill(this.col);
    noStroke();
    circle(posX, posY, this.R);
  }
  
  void draw() {
    fill(this.col);
    noStroke();
    circle(this.posX, this.posY, this.R);
  }
}
