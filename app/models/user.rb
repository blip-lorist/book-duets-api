class User < ActiveRecord::Base
  before_create :generate_api_key

  #Validations
    # Emails must be unique
    # keys must be unique

  def generate_api_key
    self.api_key = SecureRandom.base64.tr('+/=', 'xpq')
  end

end
