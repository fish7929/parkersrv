class LocalitiesController < ApplicationController
  respond_to :json, :xml, :html
	before_action :set_locality, only: [:show, :edit, :update, :destroy]


  # GET /localities
  # GET /localities.json
  def index
		level = params[:level]
		parentId = params[:parentId]
		if level == nil
			@localities = Locality.all
		else
#	@localities = Locality.select(:code, :parentId ,:name).where(level: level).all
			if parentId == nil
				@localities = Locality.where(level: level).all
			else
				@localities = Locality.where("level = ? AND parentId = ?", level, parentId).all
			end
		end
		respond_with @localities
  end


  # GET /localities/1
  # GET /localities/1.json
  def show
  end

  # GET /localities/new
  def new
    @locality = Locality.new
  end

  # GET /localities/1/edit
  def edit
  end

  # POST /localities
  # POST /localities.json
  def create
    @locality = Locality.new(locality_params)

    respond_to do |format|
      if @locality.save
        format.html { redirect_to @locality, notice: 'Locality was successfully created.' }
        format.json { render :show, status: :created, location: @locality }
      else
        format.html { render :new }
        format.json { render json: @locality.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /localities/1
  # PATCH/PUT /localities/1.json
  def update
    respond_to do |format|
      if @locality.update(locality_params)
        format.html { redirect_to @locality, notice: 'Locality was successfully updated.' }
        format.json { render :show, status: :ok, location: @locality }
      else
        format.html { render :edit }
        format.json { render json: @locality.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /localities/1
  # DELETE /localities/1.json
  def destroy
    @locality.destroy
    respond_to do |format|
      format.html { redirect_to localities_url, notice: 'Locality was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_locality
      @locality = Locality.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def locality_params
      params.require(:locality).permit(:uuid, :code, :parentId, :name, :garageNum, :level)
    end
end
