module ApplicationHelper  
	def complete_button(task)
  	if task.complete?
    	link_to "Mark Incomplete", complete_path(task), remote: true, class: 'btn btn-primary btn-xs'
  	else
    	link_to "Mark Completed", complete_path(task), remote: true, class: 'btn btn-default btn-xs'
  	end
	end

	def time_left(task)
  	if task.complete?
    	"Completed!"
  	else
    	distance_of_time_in_words_to_now(task.due_date)
  	end
	end
end
