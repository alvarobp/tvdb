require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

module TVdb
  describe Urls do
    before(:each) do
      @urls = Urls.new("api_key")
    end
    
    it "should have an api_key" do
      @urls.api_key.should == "api_key"
    end
    
    it "should have templates for default urls with base url and api key on their template value" do
      @urls.templates.size.should == Urls::URLS.size
      Urls::URLS.each do |k,v|
        @urls.templates[k].template.should == v % [Urls::BASE_URL, "api_key"]
      end
    end
    
    it "should support different base urls" do
      urls = Urls.new("api_key", "http://www.wadus.org")
      Urls::URLS.each do |k,v|
        urls.templates[k].template.should == v % ["http://www.wadus.org", "api_key"]
      end
    end
    
    it "should reference its templates" do
      @urls[:serie_url].should == @urls.templates[:serie_url]
    end
  end
  
  describe Template do
    before(:each) do
      @template_string = "Hello my name is {{name}} and I am from {{country}}."
      @template = Template.new(@template_string)
    end
    
    it "should have a template" do
      @template.template.should == @template_string
    end
    
    it "should substitute its pattern using keys and values" do
      (@template % {:name => "Alvaro", :country => "Spain"}).should == "Hello my name is Alvaro and I am from Spain."
    end
    
    it "should raise error if any value is missing" do
      lambda {@template % {:name => "Alvaro"}}.should raise_error("Value for country not found")
    end
  end
end