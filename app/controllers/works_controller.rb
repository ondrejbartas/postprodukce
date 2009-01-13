class WorksController < ApplicationController
  # GET /works
  # GET /works.xml
  def index
    if not (@current_user.admin? || @current_user.produce? || @current_user.worker? || @current_user.accountant? )
      redirect_to @current_user
    else
      @works = Work.find(:all, :conditions => "deleted is null")

      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @works }
      end
    end
  end

  # GET /works/1
  # GET /works/1.xml
  def show
    if not (@current_user.admin? || @current_user.produce? || @current_user.worker? || @current_user.accountant? )
      redirect_to @current_user
    else
      @work = Work.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @work }
      end
    end
  end

  # GET /works/new
  # GET /works/new.xml
  def new
    if not (@current_user.admin? || @current_user.produce? || @current_user.worker?)
      redirect_to @current_user
    else
      @work = Work.new

      @users = User.find(:all)
      @projects = Project.find(:all)
      @job_types = JobType.find(:all)
      @places = Place.find(:all)
      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @work }
      end
    end
  end

  # GET /works/1/edit
  def edit
    @work = Work.find(params[:id])
    if not (@current_user.mine?(@work) || @current_user.admin? || @current_user.produce? )
      redirect_to @current_user
    else
      @users = User.find(:all)
      @projects = Project.find(:all)
      @job_types = JobType.find(:all)
      @places = Place.find(:all)
    end
  end

  # POST /works
  # POST /works.xml
  def create
    if not (@current_user.worker? || @current_user.admin? || @current_user.produce? )
      redirect_to @current_user
    else
      @work = Work.new(params[:work])
      @users = User.find(:all)
      @projects = Project.find(:all)
      @job_types = JobType.find(:all)
      @places = Place.find(:all)
      respond_to do |format|
        if @work.save
          flash[:notice] = 'Work was successfully created.'
          format.html { redirect_to(@work) }
          format.xml  { render :xml => @work, :status => :created, :location => @work }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @work.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # PUT /works/1
  # PUT /works/1.xml
  def update
    @work = Work.find(params[:id])
    if not (@current_user.mine?(@work) || @current_user.admin? || @current_user.produce? )
      redirect_to @current_user
    else

      @users = User.find(:all)
      @projects = Project.find(:all)
      @job_types = JobType.find(:all)
      @places = Place.find(:all)
      respond_to do |format|
        if @work.update_attributes(params[:work])
          flash[:notice] = 'Work was successfully updated.'
          format.html { redirect_to(@work) }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @work.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /works/1
  # DELETE /works/1.xml
  def destroy
    @work = Work.find(params[:id])
    if not (@current_user.mine?(@work) || @current_user.admin? || @current_user.produce? )
      redirect_to @current_user
    else
      if @work.deleted
        @work.deleted = false
      else
        @work.deleted = true
      end
      @work.save

      respond_to do |format|
        format.html { redirect_to(works_url) }
        format.xml  { head :ok }
      end
    end
  end
end
