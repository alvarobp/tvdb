require 'ostruct'
require 'open-uri'
require 'hpricot'
require File.dirname(__FILE__) + '/tvdb/client'
require File.dirname(__FILE__) + '/tvdb/serie'

module TVdb
  SEARCH_SERIES_URL = "http://www.thetvdb.com/api/GetSeries.php?seriesname=%s&language=%s"
  SERIE_URL = "http://www.thetvdb.com/api/%s/series/%s/%s.xml"
  BANNERS_URL = "http://www.thetvdb.com/banners/_cache/%s"
end