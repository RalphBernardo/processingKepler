Plot plot;
// determined number of circles for confimed exoplanets from GetJSON
// since I know the size will use Array
Circle[] circles = new Circle[145];

int leftMargin = 0;
int rightMargin = 0;
int topMargin = 0;
int bottomMargin = 0;

int candidateCount = 0; // number of candidate exoplanets
int confirmedCount = 0; // number of confirmed exoplanets

// Once created you can not change size of Array but ArrayList can resize itself when needed
// Better reason is these structures have useful methods, see http://processing.org/reference
FloatList radii = new FloatList();
StringList names = new StringList();
IntList temps = new IntList();

// don't think I need these as global variables
//float minRadius; //exoplanet with smallest radius
//float maxRadius; //exoplanet with largest radius

// Data retrieved from http://archive.stsci.edu/kepler/data_search/search.php

// list of JSON objects
JSONArray json;

void setup() {
  json = loadJSONArray("data/kepler_confirmed_planets.json");
  // print(json); // check data
  // get example data set for one exoplanet
  println("Example Data for one exoplanet");
  println(json.getJSONObject(0));
  
  int exoplanetCount = json.size();
      
  println();
  println("Data set contains", exoplanetCount, "potential exoplanets.");
        
  for (int i = 0; i < json.size(); i++) {    
      JSONObject exoplanet = json.getJSONObject(i);
      String name = exoplanet.getString("KOI Name"); // Kepler Object of Interest number
      float radius = exoplanet.getFloat("Planet Radius"); // Planetary radius in Earth radii (6378 km)
      int temp = int(exoplanet.getString("Teq")); // Equilibrium surface temperature of planet in degrees K
      String confirmed = exoplanet.getString("NExScI Disposition");
      String candidate = exoplanet.getString("Kepler Disposition");
  
      if(confirmed.equals("CANDIDATE"))
      {
        candidateCount++;
      }
      if(confirmed.equals("CONFIRMED"))
      { 
        confirmedCount++;
        radii.append(radius); 
        names.append(name);
        temps.append(temp); 
      }   
    }
  
  println("There are", candidateCount, "exoplanet candidates.");
  println("There are", confirmedCount, "confirmed exoplanets.");
  println();
  
  //println(radii); // check radius data
  //println(names); // check name data
  //println(temps); // check temperature data
   
  // can determine from data
  // repeated code in function, but used this to figure plotting
  
  float minRadius = radii.min(); 
  float maxRadius = radii.max();
  
  println("The minimum explanet radius is", minRadius, "Earth radius.");
  println("The maximum explanet radius is", maxRadius, "Earth radius.");
  println();
  
  int minTemp = temps.min(); 
  int maxTemp = temps.max();
  
  println("The minimum explanet temperature is", minTemp, "degrees K.");
  println("The maximum explanet temperature is", maxTemp, "degrees K.");
  println();
    
  size(1080, 720);
  smooth();
  frameRate(30);
  
  // initialize plot
  plot = new Plot(leftMargin, topMargin, width - rightMargin, height - topMargin, color(0));
    
  generateValues();  
}


void draw() {
  background(255);
  
  // display plot
  plot.display();
  
  //println(confirmedCount);
  //println(radii);
  //println(minRadius, maxRadius);
  
  //display circles
  for (int i = 0; i < circles.length; i++) {
    circles[i].display();  
  }
    
  //display labels
  for (int i = 0; i < circles.length; i++) {
    circles[i].displayLabel();
  }
}

// draw a new plot when 'd' is pressed
void keyPressed() {
  if (key == 'd') {
    generateValues();
  }
}

void generateValues() {
  //println(confirmedCount);
  float minRadius = radii.min(); 
  float maxRadius = radii.max();
  int minTemp = temps.min(); 
  int maxTemp = temps.max();
  //println(minRadius, maxRadius);
  for (int i = 0; i < confirmedCount; i++) {
    // randomize x, y coordinates to plot within the sketch
    float x = random(maxRadius, plot.w() - maxRadius);
    float y = random(maxRadius, plot.h() - maxRadius);
    int t = temps.get(i); 
    int red = int(map(t, minTemp, maxTemp, 0, 255)); // use red for "hot" planets
    int blue = int(map(t, maxTemp, minTemp, 0, 255)); // use blue for "cool" planets
    color c = color(red, 0, blue);
    float r = radii.get(i);
    String n = names.get(i);
    println("name:",n, "x:",x, "y:",y, "color:",c ,"radius:",r, "temp:",t);
    circles[i] = new Circle(x + plot.topLeft.x, y + plot.topLeft.y, r, c, n, t);
    //println(circles[i]);
  }
}
