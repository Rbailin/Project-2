require 'bcrypt'


class User
  include Mongoid::Document

  attr_accessor :password

  field :name, type: String
  field :email, type: String
  field :username, type: String
  field :rating, type: String
  field :salt, type: String
  field :hashed_password, type: String


 def authenticated? password
 	self.hashed_password ==
 	BCrypt::Engine.hash_secret(password, self.salt)
 end

 before_save :hash_stuff

 private 
 def hash_stuff
 	self.salt = BCrypt::Engine.generate_salt
 	self.hashed_password = BCrypt::Engine.hash_secret self.password, self.salt
 	self.password = nil
 end
end
