#!/usr/bin/env ruby
#
# - Connectivity Checker
# -> Host/ports to check are defined by data bag "connectivity".
# -> Checks are templated out on chef client run to save on API calls.
#

require 'socket'
require 'timeout'
require 'workers'

# Connectivity checks
connectivity_checks = [
  {:port=>"22", :host=>"10.0.1.5", :item=>"sensu-server"}
]

# Task execution variables
group_connectivity  = Workers::TaskGroup.new

# Set debug flag
is_debug = (ARGV.length > 0 && ARGV[0] == 'debug')

# Print debug message if enabled
puts "Debug Mode Enabled" if is_debug

# Checking method
# http://stackoverflow.com/a/9017896
def port_open?(ip, port, seconds=2)
  Timeout::timeout(seconds) do
    begin
      TCPSocket.new(ip, port).close
      true
    rescue Errno::ECONNREFUSED, Errno::EHOSTUNREACH
      false
    end
  end
rescue Timeout::Error
  false
end

# Custom exception to raise from tasks
class ConnectivityError < StandardError; end

# Add connectivity check tasks to task group
connectivity_checks.each do |check|
  group_connectivity.add input: [check] do |input|
    check = input[0]
    group_connectivity.synchronize { puts "Checking connectivity [#{check[:host]}:#{check[:port]}]..." } if is_debug
    raise ConnectivityError.new("TCP Check failed") unless port_open?(check[:host], check[:port])
  end
end

# Execute task group in parallel
group_connectivity.run

# Output failures
group_connectivity.failures.each do |failure|
  check = failure.input[0]
  host  = check[:host]
  port  = check[:port]
  item  = check[:item]

  if failure.exception.is_a? ConnectivityError
    puts "No TCP connectivity for [#{host}:#{port}] from databag item [#{item}]"
  else
    puts "Exception while checking connectivity for [#{host}:#{port}] from databag item [#{item}] - [#{failure.exception}]"
  end
end

# Exit code (fail if we have any connection failures)
exit (group_connectivity.failures.length > 0) ? 1 : 0
