class VelocitiesController < ApplicationController
	respond_to :json, :xml, :html
  before_action :set_velocity, only: [:show, :edit, :update, :destroy]

  # GET /velocities
  # GET /velocities.json
  def index
    @velocities = Velocity.all
		respond_with @velocities
  end

  # GET /velocities/1
  # GET /velocities/1.json
  def show
  end

  # GET /velocities/new
  def new
    @velocity = Velocity.new
  end

  # GET /velocities/1/edit
  def edit
  end

  # POST /velocities
  # POST /velocities.json
  def create
    @velocity = Velocity.new(velocity_params)

    respond_to do |format|
      if @velocity.save
        format.html { redirect_to @velocity, notice: 'Velocity was successfully created.' }
        format.json { render :show, status: :created, location: @velocity }
      else
        format.html { render :new }
        format.json { render json: @velocity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /velocities/1
  # PATCH/PUT /velocities/1.json
  def update
    respond_to do |format|
      if @velocity.update(velocity_params)
        format.html { redirect_to @velocity, notice: 'Velocity was successfully updated.' }
        format.json { render :show, status: :ok, location: @velocity }
      else
        format.html { render :edit }
        format.json { render json: @velocity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /velocities/1
  # DELETE /velocities/1.json
  def destroy
    @velocity.destroy
    respond_to do |format|
      format.html { redirect_to velocities_url, notice: 'Velocity was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

	def getFullVelocities

	end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_velocity
      @velocity = Velocity.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def velocity_params
      params.require(:velocity).permit(:garage_num, :t_8am, :t_9am, :t_10am, :t_11am, :t_12pm, :t_1pm, :t_2pm, :t_3pm, :t_4pm, :t_5pm, :t_6pm, :t_7pm, :t_8pm, :t_9pm, :t_10pm_8am)
    end
end
