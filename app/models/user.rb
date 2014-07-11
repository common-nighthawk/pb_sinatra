class User < ActiveRecord::Base
  include BCrypt

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }
  validates :password, presence: true, format: { with: /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/ }

  def password
    @password ||= Password.new(password_hash)
  end

 def password=(new_password)
      @password = Password.create(new_password)
      self.password_hash = @password
    end

 def self.authenticate(email, password)
  user = User.find_by_email(email)
  if user && (user.password == password)
    return user
  else
    nil
  end
 end

end