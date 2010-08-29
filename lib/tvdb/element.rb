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
      attributes = {}
      return attributes if xml.nil? || xml.is_a?(String) && xml.empty?
      
      element_root = if xml.is_a?(Hpricot::Elem)
        xml
      else
        doc = xml.is_a?(Hpricot::Doc) ? xml : Hpricot(xml)
        
        # doc.children.nil? is true for Hpricot('')
        doc.children.nil? ? doc : (@root_name.nil? ? doc.root : doc.search(@root_name).first)
      end
      
      if element_root.children
        element_root.children.map do |child|
          unless child.is_a?(Hpricot::Text)
            attributes[child.name] = child.inner_text
          end
        end
      end
      
      attributes
    end
  end
end