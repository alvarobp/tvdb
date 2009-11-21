require 'rubygems'

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'tvdb'
require 'spec'
require 'spec/autorun'

def load_example_data
  @serie1_xml = File.read(File.dirname(__FILE__) + "/data/serie1.xml")
  @serie2_xml = File.read(File.dirname(__FILE__) + "/data/serie2.xml")
  @series_xml = @serie1_xml + @serie2_xml
  @serie1_zip = File.open(File.dirname(__FILE__) + "/data/serie1.zip")
  @serie2_zip = File.open(File.dirname(__FILE__) + "/data/serie2.zip")
end