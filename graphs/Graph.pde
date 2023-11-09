public class Graph {
  ArrayList<GraphNode> nodes = new ArrayList<GraphNode>();
  
  public Graph() {
    nodes.add(new GraphNode(mouseX, mouseY, nextLetter, null));
  }
  
  public void addNode(int x, int y, int l) {
    GraphNode cN = nodes.get(nodes.size() - 1);
    nodes.add(new GraphNode(x, y, l, cN));
  }
  
  public void drawGraph() {
    for (int n = 0; n < nodes.size() && !nodes.isEmpty(); n++) {
      GraphNode g = nodes.get(n);
      g.drawNode();
    }
    for (int n = 0; n < nodes.size() && !nodes.isEmpty(); n++) {
      GraphNode g = nodes.get(n);
      g.drawLetter();
    } 
  }
}
