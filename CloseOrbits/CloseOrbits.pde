// new project to try to plot orbits

Plot plot;
Circle[] circles = new Circle[78];

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

// float minOrbit; //exoplanet with smallest orbit
// float maxOrbit; //exoplanet with largest orbit

int AU = 10000; // Astronomical Unit in pixels

// Data retrieved from http://archive.stsci.edu/kepler/data_search/search.php

JSONArray json;

void setup() {
  json = loadJSONArray("data/kepler_confirmed_planets.json");
  
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
  
      if(confirmed.equals("CONFIRMED") && axis < 0.1)
      { 
        confirmedCount++;
        names.append(name);
        radii.append(radius); 
        temps.append(temp);
        axes.append(axis);
      }   
    }
  
  println("There are", confirmedCount, "confirmed exoplanets with < 0.1 AU.");
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
  plot = new Plot(leftMargin, topMargin, width - rightMargin, height - topMargin, color(230));
    
  generateValues();
   
}


void draw() {
  background(0);
  
  // display plot
  plot.display();
  
  // display markers
  // probably can use a loop to make these, need to figure for variable assignment
  Marker zeroAU = new Marker("0 AU", 0, height/2);
  Marker oneHundredthAU = new Marker("0.01 AU", 0.01 * AU, height/2);
  Marker twoHundredthsAU = new Marker("0.02 AU", 0.02 * AU, height/2);
  Marker threeHundredthsAU = new Marker("0.03 AU", 0.03 * AU, height/2);
  Marker fourHundredthsAU = new Marker("0.04 AU", 0.04 * AU, height/2);
  Marker fiveHundredthsAU = new Marker("0.05 AU", 0.05 * AU, height/2);
  Marker sixHundredthsAU = new Marker("0.06 AU", 0.06 * AU, height/2);
  Marker sevenHundredthsAU = new Marker("0.07 AU", 0.07 * AU, height/2);
  Marker eightHundredthsAU = new Marker("0.08 AU", 0.08 * AU, height/2);
  Marker noneHundredthsAU = new Marker("0.09 AU", 0.09 * AU, height/2);
  Marker oneTenthAU = new Marker("0.1 AU", AU/10, height/2);

  
  // plot description
  textSize(14);
  text("\"Close\" Exoplanet Orbits in AU (Average Earth-Sun Distance, ~93 million miles)", 0.027 * AU, height/6);
  
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
    // plot along x-axis
    float a = axes.get(i);
    float x = maxRadius + (a * AU);
    float y = maxRadius/2 + height/2;
    int t = temps.get(i); 
    int red = int(map(t, minTemp, maxTemp, 0, 255)); // use red for "hot" planets
    // try reducing the "blue" level
    int blue = int(map(t, maxTemp, minTemp, 0, 120)); // use blue for "cool" planets
    color c = color(red, 0, blue);
    float r = radii.get(i);
    String n = names.get(i);
    println("name:",n, "x:",x, "y:",y, "color:",c ,"radius:",r, "temp:",t ,"axis:",a);
    circles[i] = new Circle(x + plot.topLeft.x, y + plot.topLeft.y, r, c, n, t, a);
  }
}
