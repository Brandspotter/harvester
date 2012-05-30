require "harvester/version"
require "harvester/util"
require "harvester/parser"

module Harvester
  def self.new(&block)
    Parser.new(&block)
  end
end
