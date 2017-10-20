#!/usr/bin/env ruby

# file: pxindex-builder.rb

require 'wordsdotdat'
require 'phrase_lookup'
require 'polyrex-builder'


class PxIndexBuilder

  attr_reader :to_xml

  def initialize(raw_s, ignore=[])

    s, _ = RXFHelper.read(raw_s)

    h = YAML.load(s)
    words = h.keys.join(' ').split(/ +/).map {|x| x[/\w+/]}.uniq\
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

    @to_xml = PolyrexBuilder.new(scan(index), parents: %i(entry)).to_xml

  end

  private

  def scan(rows)

    rows.map do |x|

      head, body, _ = x
      
      a = [{title: head}]
      a << scan(body) if body and body.any?
      a

    end

  end

end
