module TVdb
  class Serie < Element
    def initialize(xml)
      super(xml, 'series') do |atts|
        # Turn into arrays
        atts["actors"] = atts["actors"].split('|').select{|a| !a.nil? && !a.empty?} if atts["actors"] && atts["actors"].is_a?(String) && !atts["actors"].empty?
        genres = atts.delete("genre")
        atts["genres"] = genres.split('|').select{|a| !a.nil? && !a.empty?} if genres && genres.is_a?(String) && !genres.empty?

        atts["poster"] = BANNER_URL % atts["poster"] unless atts["poster"].nil?
      end
    end
  end
  
  BANNER_URL = "http://www.thetvdb.com/banners/_cache/%s"
end
