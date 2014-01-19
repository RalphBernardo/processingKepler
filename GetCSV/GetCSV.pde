// Data retrieved from http://archive.stsci.edu/kepler/data_search/search.php

Table table;

table = loadTable("data/kepler_confirmed_planets.csv", "header");

table.removeRow(0); // data set had an extra header row for the data type

int rowCount = table.getRowCount();

int candidateCount = 0;
int confirmedCount = 0;

ArrayList radii = new ArrayList();

println("Data set contains", rowCount, "potential exoplanets.");

for(int i = 0; i < rowCount; i++)
{
  TableRow row = table.getRow(i);
  float radius = row.getFloat("Planet Radius");
  String confirmed = row.getString("NExScI Disposition");
  String candidate = row.getString("Kepler Disposition");
  //println(confirmed);
  //println(radius);
  if(confirmed.equals("CANDIDATE"))
  {
    candidateCount++;
  }
  if(confirmed.equals("CONFIRMED"))
  { 
    confirmedCount++;
    radii.add(radius);
  }
}

//println(radii);
println("There are", candidateCount, "exoplanet candidates.");
println("There are", confirmedCount, "confirmed exoplanets.");
