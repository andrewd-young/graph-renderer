import java.util.ArrayList;

int lastPosX = 0;
int lastPosY = 0;

public int nextLetter = 0;
boolean newMode = true;

String[] alphabet = {"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"};

ArrayList<Graph> graphs = new ArrayList<>();

void setup() {
  size(603, 603);
  textSize(32);
  noStroke();
}

void draw() {
  fill(256, 256, 256);
  
  for (int g = 0; g < graphs.size() && !graphs.isEmpty(); g++) {
    graphs.get(g).drawGraph();
  }
}

void mouseClicked() {
  //if(lastPosX != 0 && lastPosY != 0) {
  //  line(lastPosX, lastPosY, mouseX, mouseY);
  //}

  //fill(0, 0, 0);
  //circle(mouseX, mouseY, 20);
  //fill(255, 255, 255);
  //text(alphabet[letterIndex], mouseX, mouseY);
  //if(letterIndex == 25) {
  //  letterIndex = 0;
  //}
  //else {
  //  letterIndex++;
  //}
  //lastPosX = mouseX;
  //lastPosY = mouseY;
  
  if (newMode) {
    graphs.add(new Graph());
    newMode = false;
    nextLetter++;
  }
  else {
    graphs.get(graphs.size() - 1).addNode(mouseX, mouseY, nextLetter);
    nextLetter++;
  }
}

void keyPressed() {
  if (key == 'N' || key == 'n') {
    newMode = true;
  }
}
