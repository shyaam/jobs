class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def search_params
  	params[:q]
	end
 
	def clear_search_index
	  if params[:search_cancel]
	    params.delete(:search_cancel)
	    if(!search_params.nil?)
	      search_params.each do |key, param|
	      	search_params[key] = nil
	     	end
	    end
	  end
	end
end
