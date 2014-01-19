// let's look at the size of orbits for confirmed planets to determine how to plot

Plot plot;
// determined number from GetJSON
Circle[] circles = new Circle[145];

int leftMargin = 0;
int rightMargin = 0;
int topMargin = 0;
int bottomMargin = 0;

int candidateCount = 0; // number of candidate exoplanets
int confirmedCount = 0; // number of confirmed exoplanets

FloatList radii = new FloatList();
StringList names = new StringList();
IntList temps = new IntList();
FloatList axes = new FloatList();

// determine for plotting

//float minOrbit; //exoplanet with smallest orbit
//float maxOrbit; //exoplanet with largest orbit

int AU = 750; // Astronomical Unit in pixels

// Data retrieved from http://archive.stsci.edu/kepler/data_search/search.php

JSONArray json;

void setup() {
  json = loadJSONArray("data/kepler_confirmed_planets.json");
  // get example data set for one exoplanet
  println("Example Data for one exoplanet");
  println(json.getJSONObject(0));
  
  int exoplanetCount = json.size();
      
  println();
  println("Data set contains", exoplanetCount, "potential exoplanets.");
        
  for (int i = 0; i < json.size(); i++) {    
      JSONObject exoplanet = json.getJSONObject(i);
      String confirmed = exoplanet.getString("NExScI Disposition");
      String candidate = exoplanet.getString("Kepler Disposition");
      String name = exoplanet.getString("KOI Name"); // Kepler Object of Interest number
      float radius = exoplanet.getFloat("Planet Radius"); // Planetary radius in Earth radii (6378 km)
      int temp = int(exoplanet.getString("Teq")); // Equilibrium surface temperature of planet in degrees K
      float axis = exoplanet.getFloat("Semi-major Axis"); // Semi-major axis of orbit in AU
  
      if(confirmed.equals("CANDIDATE"))
      {
        candidateCount++;
      }
      if(confirmed.equals("CONFIRMED"))
      { 
        confirmedCount++;
        names.append(name);
        radii.append(radius); 
        temps.append(temp);
        axes.append(axis);
      }   
    }
  
  println("There are", candidateCount, "exoplanet candidates.");
  println("There are", confirmedCount, "confirmed exoplanets.");
  println();
     
  // can determine from data
  
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
  
  float minOrbit = axes.min(); 
  float maxOrbit = axes.max();
  
  println("The minimum semi-major axis is", minOrbit, "AU.");
  println("The maximum semi-major axis is", maxOrbit, "AU.");
  println();
    
  size(1080, int(maxRadius) * 9);
  smooth();
  frameRate(30);
  
  // initialize plot
  plot = new Plot(leftMargin, topMargin, width - rightMargin, height - topMargin, color(255));
    
  generateValues();  
}


void draw() {
  background(0);
  
  // display plot
  plot.display();
  
  // display markers
  Marker oneTenthAU = new Marker("0.1 AU", AU/10, height/2);
  Marker quarterAU = new Marker("0.25 AU", AU/4, height/2);
  Marker halfAU = new Marker("0.5 AU", AU/2, height/2);
  Marker threeQuartersAU = new Marker("0.75 AU", 3 * AU/4, height/2);
  Marker oneAU = new Marker("1 AU", AU, height/2);
  Marker oneAndQuarterAU = new Marker("1.25 AU", 1.25 * AU, height/2);
  
  // plot description
  //textSize(14);
  text("Length of Semi-Major Axis of Exoplanet Orbit in AU (Average Earth-Sun Distance, ~93 million miles)", 0.35 * AU, height/6);
  
  //println(confirmedCount);
  //println(radii);
  float minRadius = radii.min(); 
  float maxRadius = radii.max();
  
  //display circles
  for (int i = 0; i < circles.length; i++) {
    circles[i].display();  
  }
    
  //display labels
  for (int i = 0; i < circles.length; i++) {
    circles[i].displayLabel();
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
    // plot all along the x-axis in order to compare size of orbits
    float a = axes.get(i);
    float x = maxRadius + (a * AU);
    float y = maxRadius/2 + height/2;
    int t = temps.get(i);
    // can try to verify if color scale makes sense: expect closer planets to star to be warmer
    int red = int(map(t, minTemp, maxTemp, 0, 255)); // use red for "hot" planets
    int blue = int(map(t, maxTemp, minTemp, 0, 255)); // use blue for "cool" planets
    color c = color(red, 0, blue);
    float r = radii.get(i);
    String n = names.get(i);
    println("name:",n, "x:",x, "y:",y, "color:",c ,"radius:",r, "temp:",t ,"axis:",a);
    circles[i] = new Circle(x + plot.topLeft.x, y + plot.topLeft.y, r, c, n, t, a);
  }
}
