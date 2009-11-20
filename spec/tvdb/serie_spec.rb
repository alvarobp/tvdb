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
    
    it "should reject ignored attributes" do
      serie = Serie.new("<Series><seriesname>The Big Bang Theory</seriesname><zap2it_id>4815162342</zap2it_id><ContentRating>10</ContentRating>", 
        ["ContentRating", "zap2it_id"])
      serie.seriesname.should_not be_nil
      serie.zap2it_id.should be_nil
      serie.contentrating.should be_nil
    end
    
    it "should map id attribute to tvdb_id serie method" do
      serie = Serie.new("<Series><id>4815162342</id></Series>")
      serie.tvdb_id.should == "4815162342"
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
      serie.poster.should == TVdb::BANNERS_URL % "posters/80379-1.jpg"
    end
    
    it "should just be empty for empty xml" do
      serie = Serie.new("")
      
      serie.seriesname.should be_nil
      serie.tvdb_id.should be_nil
      serie.actors.should be_nil
      # ...
    end
  end
end