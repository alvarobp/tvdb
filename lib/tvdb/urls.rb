module TVdb
  class Urls
    BASE_URL = "http://www.thetvdb.com"
    URLS = {
      :get_series => "%s/api/GetSeries.php?seriesname={{name}}&language={{language}}",
      :serie_xml => "%s/api/%s/series/{{serie_id}}/{{language}}.xml",
      :serie_full_xml => "%s/api/%s/series/{{serie_id}}/all/{{language}}.xml",
      :serie_banners_xml => "%s/api/%s/series/{{serie_id}}/banners.xml",
      :serie_zip => "%s/api/%s/series/{{serie_id}}/all/{{language}}.zip",
      :episode_xml => "%s/api/%s/episodes/{{episode_id}}/{{language}}.xml"
    }
    
    attr_reader :api_key, :templates
    
    def initialize(api_key, base_url=BASE_URL)
      @api_key = api_key
      @templates = URLS.inject({}){|object, (k,v)| object[k] = Template.new(v % [base_url, @api_key]); object}
    end
    
    def [](key)
      @templates[key]
    end
  end
  
  class Template
    attr_reader :template
    
    def initialize(template)
      @template = template
    end
    
    def %(values)
      @template.gsub(/\{\{(.*?)\}\}/ ){
        value = values[$1] || values[$1.to_sym]
        raise "Value for #{$1} not found" if value.nil?
        value.to_s
      }
    end
  end
end