#!/usr/bin/ruby

require_relative 'Updates'

$wi.verbose = false

begin
	check_active
ensure
	close_connections
end
