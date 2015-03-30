class Project < ActiveRecord::Base
	belongs_to :user
  has_many :tasks, dependent: :destroy

	validates :name, presence: true
	validates :description, presence: true
	validate :past_due

	def past_due
		if due_date <= Time.now
			errors.add(:due_date, "nothing in the past please")
		end
	end

end
