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
		code = params[:code]
		parentId = code + "%"
		start_date = params[:start_date].to_date
		end_date = params[:end_date].to_date + 1.day
		week_day = params[:week_day].to_i
		@rect = []
		if code == "0"
			@garageNum = Locality.select(:garageNum).where(level: 5).all
		else
			@garageNum = Locality.select(:garageNum).where("level = ? AND code like ?", 5, parentId).all
		end
		@garageNum.each do |garageNum|
			get_content(garageNum.garageNum, start_date, end_date, week_day)
		end
		respond_with @rect
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
		
		def get_content(garage_uuid, start_date, end_date, week_day)
			detailContent = {}
			@information = Information.find_by("uuid = ?", garage_uuid)
			detailContent[:totalParking] = @information.total_parking_space
			detailContent[:garageName] = @information.garage_name
			if week_day == 7
				@veloc = Velocity.where("garage_num = ? AND created_at >= ? AND created_at <= ?", garage_uuid, start_date, end_date)
				detailContent[:velocityContent] = @veloc
			else
				velocContent = []
				@veloc = Velocity.where("garage_num = ? AND created_at >= ? AND created_at <= ?", garage_uuid, start_date, end_date)
				@veloc.each do |veloc|
					if veloc.created_at.wday == week_day
							velocContent.push(veloc)
					end
				end
				detailContent[:velocityContent] = velocContent
			end
			@rect.push(detailContent)
		end
end
