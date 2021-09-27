class ApiKey
  SECRET = '10ae820f-8c24-4e69-888b-03cbc36c89a6'

  class << self
    def can_access?(api_secret)
      api_secret == SECRET
    end
  end
end
