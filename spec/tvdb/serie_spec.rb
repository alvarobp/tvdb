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
    
    it "should parse episodes and return them as an array of Element objects" do
      serie = Serie.new(@serie1_full_xml)
      
      serie.episodes.size.should == 55 # There are 55 <Episode> tags in the zip file
      
      serie.episodes.first.tvdb_id.should == '1102131'
      serie.episodes.first.episodename.should == 'Physicist To The Stars'
      serie.episodes.first.seriesid.should == serie.tvdb_id
      
      serie.episodes[1].tvdb_id.should == '1088021'
      serie.episodes[1].episodename.should == 'Season 2 Gag Reel'
      
      serie.episodes.last.tvdb_id.should == '1309961'
      serie.episodes.last.episodename.should == 'The Maternal Congruence'
    end
    
  end
end