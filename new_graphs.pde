import java.util.stream.Collectors;

ArrayList<Node> nodes;
ArrayList<PVector> edges;
Node selectedNode = null;
Button dfsButton, bfsButton, clearButton;

String[] alphabet = {"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"};
int nextLetter = 0;

ArrayList<Node>[] adjacencyList = new ArrayList[26];

String searchString = "";
enum Method {
  BFS,
  DFS,
}

void setup() {
  size(800, 600);
  nodes = new ArrayList<Node>();
  edges = new ArrayList<PVector>();
  textSize(25);
  
  dfsButton = new Button(25, 50, 100, 40, "DFS");
  bfsButton = new Button(135, 50, 100, 40, "BFS");
  clearButton = new Button(25, 535, 70, 40, "Clear");
}

void draw() {
  background(255);
  for (PVector edge : edges) {
    Node n1 = nodes.get((int)edge.x);
    Node n2 = nodes.get((int)edge.y);
    line(n1.x, n1.y, n2.x, n2.y);
  }
  for (Node node : nodes) {
    node.display();
  }
  
  fill(200);
  if (selectedNode != null) {
    // Display buttons
    dfsButton.display();
    bfsButton.display();
    text("Starting at: " + alphabet[selectedNode.letter], 25, 35);
  }
  else {
    fill(0);
    text("No node selected", 25, 35);
  }
  
  clearButton.display();
  
  String adjacencyString = nodes.stream().map(Node::toString).collect(Collectors.joining("\n"));               
  
  text(adjacencyString, 25, 120);
  
  text(searchString, 245, 80);
}

int findInsertIndex(ArrayList<Node> nodes, int letter) {
  for (int i = 0; i < nodes.size(); i++) {
    if (nodes.get(i).letter > letter) {
      return i;
    }
  }
          
  return nodes.size();
}

void mousePressed() {
  if (dfsButton.isMouseOver()) {
    searchString = "Depth First Search performed: " + search(Method.DFS).stream().map(Node::getLetter).collect(Collectors.joining(", "));
    return;
  }
  if (bfsButton.isMouseOver()) {
    searchString = "Breadth First Search performed: " + search(Method.BFS).stream().map(Node::getLetter).collect(Collectors.joining(", "));
    return;
  }
  if (clearButton.isMouseOver()) {
    nodes.clear();
    edges.clear();
    searchString = "";
    selectedNode = null;
    nextLetter = 0;
    return;
  }
  
  // Check if any node is clicked
  for (Node node : nodes) {
    if (node.isMouseOver()) {
      if (selectedNode == null) {
        // Select the node if no node is currently selected
        selectedNode = node;
      }
      else if (node == selectedNode) {
        selectedNode = null;
      } else if (node != selectedNode) {
        // Connect the selected node with the clicked node
        for (PVector edge : edges) {
          if ((nodes.get((int)edge.x) == selectedNode && nodes.get((int)edge.y) == node) || (nodes.get((int)edge.y) == selectedNode && nodes.get((int)edge.x) == node)) {
            return;
          }
        }
        
        edges.add(new PVector(nodes.indexOf(selectedNode), nodes.indexOf(node)));
        
        int addIndexSelectedNode = findInsertIndex(selectedNode.getAdjacent(), node.letter);
        selectedNode.getAdjacent().add(addIndexSelectedNode, node);
    
        int addIndexNode = findInsertIndex(node.getAdjacent(), selectedNode.letter);
        node.getAdjacent().add(addIndexNode, selectedNode);
        
        selectedNode = null; // Deselect the node after connecting
      }
      return; // Exit the method to prevent creating a new node when clicking on an existing node
    }
  }

  // Create a new node if no node is clicked
  Node newNode = new Node(mouseX, mouseY);
  nodes.add(newNode);

  // If a node is selected, connect the new node to the selected node
  if (selectedNode != null) {
    edges.add(new PVector(nodes.indexOf(selectedNode), nodes.size() - 1));
    newNode.getAdjacent().add(selectedNode);
    selectedNode.getAdjacent().add(newNode);
    selectedNode = null; // Deselect the node after connecting
  }
}

class Node {
  float x, y;
  float diameter = 25; // Increased diameter for easier clicking
  int letter;
  
  ArrayList<Node> adjacentNodes = new ArrayList<Node>();

  Node(float x, float y) {
    this.x = x;
    this.y = y;
    this.letter = nextLetter;
    nextLetter++;
  }

  void display() {
    fill(0);
    if (this == selectedNode) {
      fill(255, 0, 0); // Highlight the selected node
    }
    ellipse(x, y, diameter, diameter);
    
    fill(255, 255, 255);
    text(alphabet[letter], x - 7, y + 9);
  }

  boolean isMouseOver() {
    return dist(mouseX, mouseY, x, y) < diameter / 2;
  }
  
  String getLetter() {
    return alphabet[letter];
  }
  
  String toString() {
    return alphabet[letter] + " -> " + getAdjacent().stream().map(Node::getLetter).collect(Collectors.joining(", "));
  }

  ArrayList<Node> getAdjacent() {
    return adjacentNodes;
  }
}

class Button {
  float x, y, width, height;
  String label;

  Button(float x, float y, float width, float height, String label) {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    this.label = label;
  }

  void display() {
    fill(200);
    rect(x, y, width, height, 7);
    fill(0);
    text(label, x + 5, y + height - 10);
  }

  boolean isMouseOver() {
    return mouseX >= x && mouseX <= x + width && mouseY >= y && mouseY <= y + height;
  }
}

void DFS(Node n, ArrayList<Node> visited) {
  visited.add(n);
  for (Node neighbor : n.getAdjacent()) {
    if (!visited.contains(neighbor)) {
      DFS(neighbor, visited);
    }
  }
}

void BFS(Node v0, ArrayList<Node> visited) {
  ArrayList<Node> queue = new ArrayList<Node>();
  queue.add(v0);
  while (!queue.isEmpty()) {
    Node v = queue.remove(0);
    visited.add(v);
    for (Node n : v.getAdjacent()) {
      if (!visited.contains(n) && !queue.contains(n)) {
        queue.add(n);
      }
    }
  }
}

ArrayList<Node> search(Method m) {
  ArrayList<Node> visitedNodes = new ArrayList<>();

  switch(m) {
    case DFS:
      DFS(selectedNode, visitedNodes);
      break;
    case BFS:
      BFS(selectedNode, visitedNodes);
      break;
  }

  return visitedNodes;
}
