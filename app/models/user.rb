class User < ApplicationRecord
  has_secure_password

  attr_accessor :remember_token

  
  #2 fonctions utilisées par la méthode remember
  class << self
    #Create a digest based on a string
    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                    BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    # Returns a random token.
    def new_token
      SecureRandom.urlsafe_base64
    end
  end



  def remember
    #Créer un remember_token
    self.remember_token = User.new_token
    #Met le digest de ce token dans la base de donnée
    update_attribute( :remember_digest, User.digest(@remember_token) )  
  end

  def forget
     update_attribute( :remember_digest, nil )  
  end

  #Method to identify wether the user is the right one (the digest of the input remember_token == remember_digest)
  def authenticated?(remember_token)
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end


end
