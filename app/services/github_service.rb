require 'httparty'

class GithubService
  def repos
    Rails.cache.fetch([self, :repos], expires_in: 20.minutes) { get_url("https://api.github.com/repos/aj-bailey/little-esty-shop") }
  end
  
  def pulls
    Rails.cache.fetch([self, :pulls], expires_in: 20.minutes) { get_url("https://api.github.com/repos/aj-bailey/little-esty-shop/pulls?state=closed") }
  end

  def contributors
    Rails.cache.fetch([self, :contributors], expires_in: 20.minutes) { get_url("https://api.github.com/repos/aj-bailey/little-esty-shop/contributors") }
  end

  def get_url(url)
    response = HTTParty.get(url)
    parsed = JSON.parse(response.body, symbolize_names: true)
  end
end