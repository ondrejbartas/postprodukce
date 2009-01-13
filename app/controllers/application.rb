# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '8c597388af017743bac1df1a5d278c01'

  # See ActionController::Base for details
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password").
  # filter_parameter_logging :password

  before_filter :auth
  before_filter :require_login, :except => [:login]


  helper_method :current_user

  #User.create( :login=> "korin", :password=> "heslo", :password_new => "heslo")

  # Authorise user if possible
  def auth
    unless session[:user_id].nil? then
      @current_user = User.find(session[:user_id])
      @activeRole = session[:activeRole]
    end
  end

  def current_user
    @current_user
  end

  # Require login
  def require_login
    redirect_to '/login' unless current_user
  end


end
