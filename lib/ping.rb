# Taken from http://stackoverflow.com/a/7520485
class Ping
  def self.pingecho(host, timeout=5, service="echo")
    begin
      Timeout.timeout(timeout) do
        s = TCPSocket.new(host, service)
        s.close
      end
    rescue Errno::ECONNREFUSED
      return true
    rescue Timeout::Error, StandardError
      return false
    end
    return true
  end
end
