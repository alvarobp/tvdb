module TVdb
  class Serie < OpenStruct
    def initialize(xml)
      atts = attributes_from_xml(xml)
      
      # Downcase the keys
      atts = atts.inject({}){|options, (k,v)| options[k.downcase] = v; options}
      
      # Don't mess with Object.id
      if atts.has_key?('id')
        sid = atts.delete('id')
        atts[:tvdb_id] = sid
      end
      
      # Turn into arrays
      atts["actors"] = atts["actors"].split('|').select{|a| !a.nil? && !a.empty?} if atts["actors"] && atts["actors"].is_a?(String) && !atts["actors"].empty?
      genres = atts.delete("genre")
      atts["genres"] = genres.split('|').select{|a| !a.nil? && !a.empty?} if genres && genres.is_a?(String) && !genres.empty?
      
      atts["poster"] = BANNER_URL % atts["poster"] unless atts["poster"].nil?
      
      super(atts)
    end
    
    private
    
    def attributes_from_xml(xml)
      return {} if xml.nil? || xml.empty?
      doc = Hpricot(xml)
      
      attributes = {}
      doc.search('series').first.children.map do |child|
        unless child.is_a?(Hpricot::Text)
          attributes[child.name] = child.inner_text
        end
      end
      attributes
    end
  end
  
  BANNER_URL = "http://www.thetvdb.com/banners/_cache/%s"
end
