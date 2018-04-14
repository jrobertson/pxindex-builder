#!/usr/bin/env ruby

# file: pxindex-builder.rb

require 'line-tree'
require 'wordsdotdat'
require 'phrase_lookup'
require 'polyrex-builder'


class PxIndexBuilder

  attr_reader :to_xml, :to_h, :to_s
  
  def initialize(obj, debug: false, ignore: [])
    
    @debug = debug
    puts 'inside initialize: ' if @debug
    
    if obj.is_a? String then
    
      s, _ = RXFHelper.read(obj)
      
      s =~ /^---/ ?  import_phrases(YAML.load(s), s, ignore) : import_index(s)
      
    elsif obj.is_a? Hash
      import_phrases obj, s, ignore
    end
    
  end
  
  
  private
  
  def import_index(raw_s)
    
    # find the entries which aren't on the main index
    s = raw_s.sub(/<[^>]+>\n/,'')
    doc = LineTree.new(s, debug: @debug).to_doc(encapsulate: true)
    a = doc.root.xpath('entry/text()')
    puts 'doc: ' + doc.xml if @debug
    a2 = doc.root.xpath('entry//entry/text()')
    puts 'a2: ' + a2.inspect if @debug
    a3 = a2 - a
    puts 'a3:' + a3.inspect if @debug
    
    # add the new entries to the main index
    s << "\n" + a3.join("\n")

    s.prepend '<?ph schema="entries/section[heading]/entry[title, url]"?>

    '
    
    @to_s = s
      
  end
  
  def import_phrases(h, s, ignore=[])

    words = h.keys.join(' ').split(/ +/).map {|x| x[/\w+/]}.uniq\
      #.tap {|x| puts 't: ' + x.inspect}
      .reject {|x| x.length < 3}\
      .reject {|x| ignore.include? x}\
      .reject {|x| x.length < 4 and !WordsDotDat.list.include? x.downcase}\
      .group_by(&:chr).sort

    pl = PhraseLookup.new s  

    index = words.map do |letter, list|

      a = list.map do |w| 
        phrases = pl.q(w)
        [w, phrases, phrases.map {|x| h[x] }.max]
      end

      [letter, a.sort_by(&:last).reverse]

    end

    @to_h = h = scan(index)
    puts 'h: ' + h.inspect if @debug
    @to_xml = PolyrexBuilder.new(h, parents: %i(entry)).to_xml


  end



  def scan(rows)

    rows.map do |x|

      head, body, _ = x
      
      a = [{title: head}]
      a << scan(body) if body and body.any?
      a

    end

  end

end
