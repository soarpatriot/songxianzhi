class Subdomain
  def self.matches?(request)
    case request.subdomain
      when 'www', '', 'test', 'static',nil
        false
      else
        true
    end
  end
end