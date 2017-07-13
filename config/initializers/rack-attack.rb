class Rack::Attack
  throttle('req/ip', :limit => 10, :period => 1.minutes) do |req|
    req.ip
  end

  throttle('req/ipnonget', :limit => 3, :period => 1.minutes) do |req|
    req.ip unless req.get?
  end

end