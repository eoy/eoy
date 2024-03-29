class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?

  has_many :posts

  def set_default_role
    self.role ||= :user
  end

end
