require 'ostruct'
require 'open-uri'
require 'hpricot'
require 'zip/zip'

# OpenURI by default returns StringIO objects for responses up to 10K 
# and creates temporary files for greater responses, so we force it to
# always create temporary files since ZipFile only accepts filenames
OpenURI::Buffer::StringMax = 0

require File.dirname(__FILE__) + '/tvdb/urls'
require File.dirname(__FILE__) + '/tvdb/client'
require File.dirname(__FILE__) + '/tvdb/element'
require File.dirname(__FILE__) + '/tvdb/serie'