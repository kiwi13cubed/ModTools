#!/usr/bin/ruby

require_relative 'ModTools'
require 'yaml'

THIS_FILE = File.symlink?(__FILE__) ? File.readlink(__FILE__) : __FILE__
END_LINE = "--------------------"

actname = File.expand_path("../active_games", THIS_FILE)
unless File.exist?(actname)
	puts "active_games not found"
	puts END_LINE
	exit
end
activefile = File.open(actname, "r")
if activefile.lines.count == 0
	puts "no active games"
	puts END_LINE
	exit
end

@@pl = PlayerList.new(File.expand_path("../players", THIS_FILE))
@@wi = Interface.new(File.expand_path("../default_auth", THIS_FILE))

begin
	for filename in activefile.lines
		puts "Opening #{filename}"
		if (File.exist?(filename))
			m = ModTools.load(filename)
		else
			next
		end

		m.update
		m.scan(true)
		m.tally
		m.save
	end
ensure
	@@wi.stop
	puts END_LINE
end
