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
}

void draw() {
  fill(256, 256, 256);
  background(200);
  
  for (int g = 0; g < graphs.size() && !graphs.isEmpty(); g++) {
    Graph thisGraph = graphs.get(g);
    //for (int n = 0; n < thisGraph.getNodes().size() && !thisGraph.getNodes().isEmpty(); n++) {
    //  GraphNode thisNode = thisGraph.getNodes().get(n);
    //  double distance = Math.sqrt(Math.pow((thisNode.xPos + thisNode.yPos), 2) + Math.pow((mouseX + mouseY), 2));
    //  text(20, distance, 100, 100);
    //  if (distance < 30) {
    //    thisNode.selected = true;
    //  }
    //}
    thisGraph.drawGraph();
  }
}

void mouseClicked() {
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
