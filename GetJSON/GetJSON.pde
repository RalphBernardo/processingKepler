// Data retrieved from http://archive.stsci.edu/kepler/data_search/search.php

JSONArray json;

json = loadJSONArray("data/kepler_confirmed_planets.json");
// print(json); // check data
// get example data set for one exoplanet
println("Example Data for one exoplanet");
println(json.getJSONObject(0));

int exoplanetCount = json.size();

int candidateCount = 0;
int confirmedCount = 0;

ArrayList radii = new ArrayList();

println();
println("Data set contains", exoplanetCount, "potential exoplanets.");

for (int i = 0; i < json.size(); i++) {    
    JSONObject exoplanet = json.getJSONObject(i);
    String name = exoplanet.getString("KOI Name");
    float radius = exoplanet.getFloat("Planet Radius");
    String confirmed = exoplanet.getString("NExScI Disposition");
    String candidate = exoplanet.getString("Kepler Disposition");

    if(confirmed.equals("CANDIDATE"))
    {
      candidateCount++;
    }
    if(confirmed.equals("CONFIRMED"))
    { 
      confirmedCount++;
      radii.add(radius);
      //println(name, radius);
    }   
  }

println("There are", candidateCount, "exoplanet candidates.");
println("There are", confirmedCount, "confirmed exoplanets.");
