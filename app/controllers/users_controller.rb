class UsersController < ApplicationController
	before_action :authenticate_user!
	before_action :set_user
  
  def profile
  
  end

  def show
  
  end

  def index
  
  end

  private
  	def set_user
  		@user = current_user
  	end
end
