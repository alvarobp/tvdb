require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

module TVdb
  describe Element do
    before(:each) do
      load_example_data
    end
    
    it "should map id attribute to tvdb_id serie method" do
      element = Element.new("<Element><id>4815162342</id></Element>")
      element.tvdb_id.should == "4815162342"
      
      element = Element.new("<Wadus><id>3210</id></Wadus>")
      element.tvdb_id.should == "3210"
    end
    
    it "should have a method returning each root children by default" do
      element = Element.new('<Element><attribute1>The one</attribute1><second>2</second><last>inphinity</last></Element>')
      element.attribute1.should == "The one"
      element.second.should == "2"
      element.last.should == "inphinity"
    end
    
    it "should have a method returning each children of the first element of the given name" do
      element = Element.new('<Data><List><Element><attribute1>The one</attribute1><second>2</second><last>inphinity</last></Element></List></Data>', 'element')
      element.attribute1.should == "The one"
      element.second.should == "2"
      element.last.should == "inphinity"
    end
    
    it "should accept a block that takes an attributes hash parameter to process elements" do
      element = Element.new('<Element><attribute1>The one</attribute1><second>2</second></Element>') do |attributes|
        attributes['attribute1'] += " and only"
        attributes['attribute2'] = attributes['second']
        attributes.delete('second')
      end
      
      element.attribute1.should == "The one and only"
      element.attribute2.should == "2"
      element.second.should be_nil
    end
    
    it "should behave with empty xml" do
      element = Element.new("")
      
      element.wadus.should be_nil
    end
  end
end