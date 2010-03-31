module TVdb
  class Element < OpenStruct
    def initialize(xml, root_name=nil)
      @root_name = root_name
      
      atts = attributes_from_xml(xml)
      
      # Downcase the keys
      atts = atts.inject({}){|options, (k,v)| options[k.downcase] = v; options}
      
      # Don't mess with Object.id
      if atts.has_key?('id')
        sid = atts.delete('id')
        atts[:tvdb_id] = sid
      end
      
      yield(atts) if block_given?
      
      super(atts)
    end
    
    protected
    
    def attributes_from_xml(xml)
      return {} if xml.nil? || xml.empty?
      doc = Hpricot(xml)
      
      attributes = {}
      
      element_root = @root_name.nil? ? doc.root : doc.search(@root_name).first
      
      element_root.children.map do |child|
        unless child.is_a?(Hpricot::Text)
          attributes[child.name] = child.inner_text
        end
      end
      attributes
    end
  end
end