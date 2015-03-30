class User < ActiveRecord::Base
	has_many :projects
	has_many :tasks
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
