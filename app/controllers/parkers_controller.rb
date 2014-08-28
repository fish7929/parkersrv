class ParkersController < ApplicationController
	respond_to :json, :xml, :html
  before_action :set_parker, only: [:show, :edit, :update, :destroy]

  # GET /parkers
  # GET /parkers.json
  def index
    @parkers = Parker.all
		respond_with @parkers
  end

  # GET /parkers/1
  # GET /parkers/1.json
  def show
  end

  # GET /parkers/new
  def new
    @parker = Parker.new
  end

  # GET /parkers/1/edit
  def edit
  end

  # POST /parkers
  # POST /parkers.json
  def create
    @parker = Parker.new(parker_params)

    respond_to do |format|
      if @parker.save
        format.html { redirect_to @parker, notice: 'Parker was successfully created.' }
        format.json { render :show, status: :created, location: @parker }
      else
        format.html { render :new }
        format.json { render json: @parker.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /parkers/1
  # PATCH/PUT /parkers/1.json
  def update
    respond_to do |format|
      if @parker.update(parker_params)
        format.html { redirect_to @parker, notice: 'Parker was successfully updated.' }
        format.json { render :show, status: :ok, location: @parker }
      else
        format.html { render :edit }
        format.json { render json: @parker.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /parkers/1
  # DELETE /parkers/1.json
  def destroy
    @parker.destroy
    respond_to do |format|
      format.html { redirect_to parkers_url, notice: 'Parker was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_parker
      @parker = Parker.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def parker_params
      params.require(:parker).permit(:garage_name, :point, :total_parking_spaces, :remaining_parking_spaces, :address, :price, :isOpen, :status, :road_garage)
    end
end
