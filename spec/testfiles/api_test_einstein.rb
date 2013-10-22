require 'json'
require 'rest_client'


# TODO: stub out later with VCR
def testoutput
  JSON.parse(RestClient.get "http://en.wikipedia.org/w/api.php?action=query&prop=extracts&format=json&titles=Albert%20Einstein")
end
<<<<<<< Updated upstream
def testoutput2
  JSON.parse(RestClient.get "http://en.wikipedia.org/w/api.php?action=query&prop=extracts&format=json&titles=Cottage%20Lake%2C%20Washington")
end

def content
  "<p><b>Cottage Lake</b> is a census-designated place (CDP) in King County, Washington, United States. The population was 22,494 at the 2010 census. The lake itself falls within the 98072 zip code, while the developments east of the lake fall under the 98077 zip code.</p>\n<p>Based on per capita income, Cottage Lake ranks 13th of 522 areas in the state of Washington to be ranked.</p>\n<pre>\n Coldwell Banker  ranked Cottage Lake #1 in 2013 for the fastest growing suburb in America.\n</pre>\n<p>http://www.businessinsider.com/best-suburbs-in-america-2013-6?op=1</p>\n<h2>Geography</h2>\n<p>Cottage Lake is located at 47°44′42″N 122°4′58″W (47.744892, -122.082675).</p>\n<p>According to the United States Census Bureau, the CDP has a total area of 23.0 square miles (59.4 km²), of which, 22.8 square miles (59.1 km²) of it is land and 0.1 square miles (0.4 km²) of it (0.61%) is water.</p>\n<h2>Demographics</h2>\n<p>As of the census of 2000, there were 24,330 people, 7,772 households, and 6,800 families residing in the CDP. The population density was 1,066.5 people per square mile (411.8/km²). There were 7,916 housing units at an average density of 347.0/sq mi (134.0/km²). The racial makeup of the CDP was 92.27% White, 0.34% Native American, 3.77% Asian, 0.18% Pacific Islander, 1.35% from other races, and 2.65% from two or more races. Hispanic or Latino of any race were 2.96% of the population.</p>\n<p>There were 7,772 households out of which 51.8% had children under the age of 18 living with them, 79.7% were married couples living together, 5.2% had a female householder with no husband present, and 12.5% were non-families. 9.3% of all households were made up of individuals and 1.7% had someone living alone who was 65 years of age or older. The average household size was 3.13 and the average family size was 3.34 which far exceeds the U.S. average of 1.9.</p>\n<p>In the CDP the population was spread out with 33.0% under the age of 18, 5.4% from 18 to 24, 28.3% from 25 to 44, 28.9% from 45 to 64, and 4.5% who were 65 years of age or older. The median age was 37 years. For every 100 females there were 101.3 males. For every 100 females age 18 and over, there were 101.5 males.</p>\n<p>According to a 2007 estimate, the median income for a household in the CDP was $131,565, and the median income for a family was $136,568. Males had a median income of $71,276 versus $40,935 for females. The per capita income for the CDP was $39,763. About 2.1% of families and 2.7% of the population were below the poverty line, including 3.5% of those under age 18 and 3.3% of those age 65 or over.</p>\n<h2>References</h2>\n\n<ol class=\"references\"><li id=\"cite_note-GR2-1\">^ <sup><i><b>a</b></i></sup> <sup><i><b>b</b></i></sup> \"American FactFinder\". United States Census Bureau. Retrieved 2008-01-31. </li>\n<li id=\"cite_note-GR3-2\"><b>^</b> \"US Board on Geographic Names\". United States Geological Survey. 2007-10-25. Retrieved 2008-01-31. </li>\n<li id=\"cite_note-GR1-3\"><b>^</b> \"US Gazetteer files: 2010, 2000, and 1990\". United States Census Bureau. 2011-02-12. Retrieved 2011-04-23. </li>\n</ol>"

end

def test_hash 
{"query" => {"pages"=>{"137989"=>{"pageid"=>137989, "ns"=>0, "title"=>"Cottage Lake, Washington", "extract"=> "what" }}}}
=======

def jsontestoutput
  RestClient.get "http://en.wikipedia.org/w/api.php?action=query&prop=extracts&format=json&titles=Albert%20Einstein"
end

def testoutput2
  JSON.parse(RestClient.get "http://en.wikipedia.org/w/api.php?action=query&prop=extracts&format=json&titles=Albert%20Einstein")
end

def testhash
  {"key1" => { "key2" => { "key3"=> "value", "key4"=> "value2", "key3" => "value3"}}}
>>>>>>> Stashed changes
end