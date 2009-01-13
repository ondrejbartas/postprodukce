class PlacesController < ApplicationController
  # GET /places
  # GET /places.xml
  def index

    if not (@current_user.admin? || @current_user.produce? || @current_user.worker?)

      redirect_to @current_user
    else

      @places = Place.find(:all , :conditions => "deleted is null")

      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @places }
      end
    end
  end

  # GET /places/1
  # GET /places/1.xml
  def show

    if not (@current_user.admin? || @current_user.produce? || @current_user.worker?)
      redirect_to @current_user
    else

      @place = Place.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @place }
      end
    end
  end

  # GET /places/new
  # GET /places/new.xml
  def new

    if not (@current_user.admin?)
      redirect_to @current_user
    else
      @place = Place.new

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @place }
      end
    end
  end

  # GET /places/1/edit
  def edit

    if not (@current_user.admin?)
      redirect_to @current_user
    else
      @place = Place.find(params[:id])
    end
  end

  # POST /places
  # POST /places.xml
  def create

    if not (@current_user.admin? )
      redirect_to @current_user
    else
      @place = Place.new(params[:place])

      respond_to do |format|
        if @place.save
          flash[:notice] = 'Place was successfully created.'
          format.html { redirect_to(@place) }
          format.xml  { render :xml => @place, :status => :created, :location => @place }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @place.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # PUT /places/1
  # PUT /places/1.xml
  def update

    if not (@current_user.admin? )

      redirect_to @current_user
    else
      @place = Place.find(params[:id])

      respond_to do |format|
        if @place.update_attributes(params[:place])
          flash[:notice] = 'Place was successfully updated.'
          format.html { redirect_to(@place) }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @place.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /places/1
  # DELETE /places/1.xml
  def destroy


    if not (@current_user.admin?)
      redirect_to @current_user
    else
      @place = Place.find(params[:id])
      if @place.deleted
        @place.deleted = false
      else
        @place.deleted = true
      end
      @place.save

      respond_to do |format|
        format.html { redirect_to(places_url) }
        format.xml  { head :ok }
      end
    end
  end
end
