require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

module TVdb
  describe Serie do
    before(:each) do
      load_example_data
    end
    
    it "should build from TheTVDB serie xml" do
      serie = Serie.new(@serie1_xml)
      serie.seriesname = "The Big Bang Theory"
      serie.firstaired = "2007-09-01"
      serie.imdb_id = "tt0898266"
      serie.status = "Continuing"
    end
    
    it "should map actors field to an array" do
      serie = Serie.new("<Series><actors>|Humphrey Bogart|</actors></Series>")
      serie.actors.should == ["Humphrey Bogart"]
      
      serie = Serie.new("<Series><actors>|Humphrey Bogart|Ingrid Bergman|Paul Henreid|</actors></Series>")
      serie.actors.should == ["Humphrey Bogart", "Ingrid Bergman", "Paul Henreid"]
    end
    
    it "should map genre field to field genres as an array" do
      serie = Serie.new("<Series><genre>|Comedy|</genre></Series>")
      serie.genres.should == ["Comedy"]
      
      serie = Serie.new("<Series><genre>|Comedy|Romance|</genre></Series>")
      serie.genres.should == ["Comedy", "Romance"]
    end
    
    it "should convert poster attribute to a TheTVDB banner url" do
      serie = Serie.new("<Series><poster>posters/80379-1.jpg</poster></Series>")
      serie.poster.should == TVdb::BANNER_URL % "posters/80379-1.jpg"
    end
    
  end
end