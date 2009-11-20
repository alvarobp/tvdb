module TVdb
  class Client
    attr_accessor :api_key
    
    def initialize(api_key)
      self.api_key = api_key
    end
    
    def search(title, options={})
      default_options = {:lang => 'en'}
      options = default_options.merge(options)
      
      search_url = SEARCH_SERIES_URL % [URI.escape(title), options[:lang]]
      
      xml = OpenURI.open_uri(search_url).read
      doc = Hpricot(xml)
      
      doc.search('series').search('id').map(&:inner_text).map do |sid|
        serie_xml = get_serie_info(sid, options[:lang])
        
        serie_xml && !serie_xml.empty? ? Serie.new(serie_xml, options[:ignore_attributes]) : nil
      end.compact
    end
    
    def serie_in_language(serie, lang)
      return nil if !serie.respond_to?(:tvdb_id)
      return serie if lang == serie.language

      xml = get_serie_info(serie.tvdb_id, lang)
      xml && !xml.empty? ? Serie.new(xml) : nil
    end
    
    def get_serie_info(id, lang='en')
      serie_url = SERIE_URL % [@api_key, id, lang]
      
      begin
        return OpenURI.open_uri(serie_url).read
      rescue OpenURI::HTTPError # 404 errors for some of the ids returned in search
        return nil
      end
    end
  end
end