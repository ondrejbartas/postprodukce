class UsersController < ApplicationController
  # GET /users
  # GET /users.xml
  def index
    @users = User.find(:all , :conditions => "deleted is null").sort_by {|u| u.name.downcase}

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end


   def client
     @users = User.find(:all , :conditions => ["deleted is null AND role % :rol = 0 ", {:rol => Role.find_by_name("CLIENT").getidd}]).sort_by{|u| u.name.downcase}

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  def worker
     @users = User.find(:all , :conditions => ["deleted is null AND role % :rol = 0 ", {:rol => Role.find_by_name("WORKER").getidd}]).sort_by {|u| u.name.downcase}
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
      @user = User.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @user }
      end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    if not (@current_user.admin? || @current_user.produce? )
      redirect_to @current_user
    else

      @user = User.new

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @user }
      end
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
    if not (@current_user.mine?(@user) || @current_user.admin? || @current_user.produce? )
      redirect_to @current_user
    end
  end

  # POST /users
  # POST /users.xml
  def create
    if not ( @current_user.admin? || @current_user.produce? )
      redirect_to @current_user
    else

      if !params[:contact][:name].blank?
        @user.contacts.build(params[:contact])
        @contacts = Contact.new(params[:contact])
      end

         @user.role = 1
         if !params[:role3].blank? then @user.role *= 3 end
         if !params[:role5].blank? then @user.role *= 5 end
         if !params[:role7].blank? then @user.role *= 7 end
         if !params[:role11].blank? then @user.role *= 11 end
         if !params[:role13].blank? then @user.role *= 13 end

      respond_to do |format|
        if @user.save
          flash[:notice] = 'User was successfully created.'
          format.html { redirect_to(@user) }
          format.xml  { render :xml => @user, :status => :created, :location => @user }
        else
           @contacts = @user.contacts
           format.html { render :action => "new" }
           format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }

        end
    end
  end

 
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])
    if not (@current_user.mine?(@user) || @current_user.admin? || @current_user.produce? )
      redirect_to @current_user
    else

      respond_to do |format|
          if @user.update_attributes(params[:user])
             @user.role = 1
           if !params[:role3].blank? then @user.role *= 3 end
           if !params[:role5].blank? then @user.role *= 5 end
           if !params[:role7].blank? then @user.role *= 7 end
           if !params[:role11].blank? then @user.role *= 11 end
           if !params[:role13].blank? then @user.role *= 13 end
            @user.save
            flash[:notice] = 'User was successfully updated.'

            format.html { redirect_to(@user) }
            format.xml  { head :ok }
          else
               format.html { render :action => "edit" }
               format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
          end

        end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
 def destroy
    @user = User.find(params[:id])
    if not ( @current_user.admin? || @current_user.produce? )
      redirect_to @current_user
    else

     if @user.deleted
        @user.deleted = false
      else
        @user.deleted = true
      end
      @user.save

      respond_to do |format|
        format.html { redirect_to(users_url) }
        format.xml  { head :ok }
      end
    end
 end
end
