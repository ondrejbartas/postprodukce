class AccountController < ApplicationController

  def login
    if request.post?
      @current_user = User.authenticate(params['user']['login'],
                                        params['user']['password'])
      if @current_user
        minRole = @current_user.role
        for role in Role.find(:all) 
          if minRole % role.idd == 0
            minRole = role.id
            minRoleN = role.name
          end
        end
        session[:activeRole] = minRoleN
        @activeRole = minRoleN
        session[:user_id] = @current_user.id
        redirect_to user_url(@current_user.id)
      else
        flash[:error] = 'Špatná kombinace jména a hesla'
        redirect_to login_url
      end
    end
  end

  def logout
    reset_session
    flash[:info] = 'Odhlásit'
    redirect_to login_url
  end

  def admin
    session[:activeRole] = "admin"
    @activeRole = session[:activeRole]
    redirect_to users_url
  end

  def accountant
    session[:activeRole] = "accountant"
    @activeRole = session[:activeRole]
    redirect_to users_url
  end

  def client
    session[:activeRole] = "client"
    @activeRole = session[:activeRole]
    redirect_to users_url
  end

  def produce
    session[:activeRole] = "produce"
    @activeRole = session[:activeRole]
    redirect_to users_url
  end

  def worker
    session[:activeRole] = "worker"
    @activeRole = session[:activeRole]
    redirect_to users_url
  end

end
