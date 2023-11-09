public class GraphNode {
  int xPos;
  int yPos;
  int letter;
  
  boolean selected = false;
  
  ArrayList<GraphNode> connectedNodes = new ArrayList<GraphNode>();
  
  public GraphNode(int x, int y, int l, GraphNode cN) {
    xPos = x;
    yPos = y;
    letter = l;
    if (cN != null) {
      connectedNodes.add(cN);
    }
  }
  
  public void drawNode() {
    if (selected) {
      fill(255, 0, 0);
      circle(xPos, yPos, 25);
    }
    
    fill(0, 0, 0);
    circle(xPos, yPos, 20);
    
    for (int n = 0; n < connectedNodes.size() && !connectedNodes.isEmpty(); n++) {
      int connX = connectedNodes.get(n).xPos;
      int connY = connectedNodes.get(n).yPos;
      line(xPos, yPos, connX, connY);
    }
    

  }
  
  public void drawLetter() {
    fill(255, 255, 255);
    textSize(30);
    text(alphabet[letter], xPos, yPos);
  }
  
  public String toString() {
    return this.xPos + ", " + this.yPos + this.letter;
  }
}
