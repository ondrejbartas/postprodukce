class ProjectsController < ApplicationController
  # GET /projects
  # GET /projects.xml
  def index
    @projects = Project.find(:all, :conditions => "deleted is null").sort_by {|u| u.name.downcase}

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @projects }
    end
  end

  # GET /projects/1
  # GET /projects/1.xml
  def show
    @project = Project.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @project }
    end
  end

  # GET /projects/new
  # GET /projects/new.xml
  def new
    if not (@current_user.admin? || @current_user.produce? )
      redirect_to @current_user
    else

      @project = Project.new

      if !params[:user_id].blank?
        @user = User.find(params[:user_id])
      else
        @users = User.find( :all , :conditions => ["deleted is null AND role % :rol = 0 ", {:rol => Role.find_all_by_name("CLIENT")}]).sort_by {|u| u.name.downcase}
      end

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @project }
      end
    end
  end

  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])
  end

  # POST /projects
  # POST /projects.xml
  def create
     if not (@current_user.admin? || @current_user.produce? )
      redirect_to @current_user
    else

      @project = Project.new(params[:project])

      if !params[:user_id].blank?
        @user = User.find(params[:user_id])
      else
        @users = User.find( :all , :conditions => ["deleted is null AND role % :rol = 0 ", {:rol => Role.find_all_by_name("CLIENT")}]).sort_by {|u| u.name.downcase}
      end

      respond_to do |format|
        if @project.save
          flash[:notice] = 'Project was successfully created.'
          format.html { redirect_to(@project) }
          format.xml  { render :xml => @project, :status => :created, :location => @project }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.xml
  def update
    if not (@current_user.admin? || @current_user.produce? )
      redirect_to @current_user
    else

      @project = Project.find(params[:id])

      respond_to do |format|
        if @project.update_attributes(params[:project])
          flash[:notice] = 'Project was successfully updated.'
          format.html { redirect_to(@project) }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.xml
  def destroy
    if not (@current_user.admin? || @current_user.produce? )
      redirect_to @current_user
    else

      @project = Project.find(params[:id])
      @project.destroy
      if @project.deleted
        @project.deleted = false
      else
        @project.deleted = true
      end
      @project.save

      respond_to do |format|
        format.html { redirect_to(projects_url) }
        format.xml  { head :ok }
      end
    end
  end
end
