class User < ActiveRecord::Base
  before_create :generate_api_key

  def generate_api_key
    self.api_key = SecureRandom.base64.tr('+/=', 'xpq')
  end

end
