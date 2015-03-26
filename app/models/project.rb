class Project < ActiveRecord::Base
	
validates :name, presence: true
validates :description, presence: true
validates_datetime :due_date, presence: true, :after => lambda { Time.current }
end
