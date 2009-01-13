class ContactsController < ApplicationController
  # GET /contacts
  # GET /contacts.xml
  def index
    @contacts = Contact.find(:all , :conditions => "deleted is null")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @contacts }
    end
  end

  # GET /contacts/1
  # GET /contacts/1.xml
  def show
    @contact = Contact.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @contact }
    end
  end

  # GET /contacts/new
  # GET /contacts/new.xml
   def new
    @user = User.find(params[:user_id])
    if not ( @current_user.id == @user.id || @current_user.admin? || @current_user.produce? )
     redirect_to @current_user
    else

      @contact =  @user.contacts.build

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @contact }
      end
    end
  end

  # GET /contacts/1/edit
  def edit
    @contact = Contact.find(params[:id])
    if not ( @current_user.mine?(@contact) || @current_user.admin? || @current_user.produce? )
     redirect_to @current_user
    end
  end

  # POST /contacts
  # POST /contacts.xml
  def create
    @user = User.find(params[:contact][:user_id])
    if not ( @current_user.id == @user.id || @current_user.admin? || @current_user.produce? )
     redirect_to @current_user
    else
      @contact = @user.contacts.build(params[:contact])
      if @user.save
        flash[:notice] = 'Contact was successfully created.'
        redirect_to user_url(@user)
      else
        @title = 'Nová kategorie'
        render :action => "new"
      end
    end
  end

  # PUT /contacts/1
  # PUT /contacts/1.xml
  def update
    @contact = Contact.find(params[:id])
    if not ( @current_user.mine?(@contact) || @current_user.admin? || @current_user.produce? )
     redirect_to @current_user
    else

      respond_to do |format|
        if @contact.update_attributes(params[:contact])
          flash[:notice] = 'Contact was successfully updated.'
          format.html { redirect_to(@contact) }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @contact.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.xml
  def destroy
    @contact = Contact.find(params[:id])
    if not ( @current_user.mine?(@contact) || @current_user.admin? || @current_user.produce? )
     redirect_to @current_user
    else

      if @contact.deleted
        @contact.deleted = false
      else
        @contact.deleted = true
      end
      @contact.save

      @user = User.find(params[:user_id])
      respond_to do |format|
        format.html { redirect_to user_url(@user) }
        format.xml  { head :ok }
      end
    end
  end
end
