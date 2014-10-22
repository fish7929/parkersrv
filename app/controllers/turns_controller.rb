class TurnsController < ApplicationController
	respond_to :json, :xml, :html
  before_action :set_turn, only: [:show, :edit, :update, :destroy]

  # GET /turns
  # GET /turns.json
  def index
    @turns = Turn.all
		respond_with @turns
  end

  # GET /turns/1
  # GET /turns/1.json
  def show
  end

  # GET /turns/new
  def new
    @turn = Turn.new
  end

  # GET /turns/1/edit
  def edit
  end

  # POST /turns
  # POST /turns.json
  def create
    @turn = Turn.new(turn_params)

    respond_to do |format|
      if @turn.save
        format.html { redirect_to @turn, notice: 'Turn was successfully created.' }
        format.json { render :show, status: :created, location: @turn }
      else
        format.html { render :new }
        format.json { render json: @turn.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /turns/1
  # PATCH/PUT /turns/1.json
  def update
    respond_to do |format|
      if @turn.update(turn_params)
        format.html { redirect_to @turn, notice: 'Turn was successfully updated.' }
        format.json { render :show, status: :ok, location: @turn }
      else
        format.html { render :edit }
        format.json { render json: @turn.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /turns/1
  # DELETE /turns/1.json
  def destroy
    @turn.destroy
    respond_to do |format|
      format.html { redirect_to turns_url, notice: 'Turn was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

	def getFullTurns
		code = params[:code]
		parentId = code + "%"
		garage_uuid = params[:garage_uuid]

		first_week = params[:first_week]
		first_end_date = first_week.to_date + 1.day
		first_start_date = first_end_date - 7.day

		second_week = params[:second_week]
		second_end_date = second_week.to_date + 1.day
		second_start_date = second_end_date - 7.day

		third_week = params[:third_week]
		third_end_date = third_week.to_date + 1.day
		third_start_date = third_end_date - 7.day

		four_week = params[:four_week]
		four_end_date = four_week.to_date + 1.day
		four_start_date = four_end_date - 7.day
		@rect = {}
		@newrect = []
		if garage_uuid != "0"
			get_content(garage_uuid, first_start_date, first_end_date, second_start_date, second_end_date, third_start_date, third_end_date, four_start_date, four_end_date)
		else
			if code == "0"
				@garageNum = Locality.select(:garageNum).where(level: 5).all
			else
				@garageNum = Locality.select(:garageNum).where("level = ? AND code like ?", 5, parentId ).all
			end
			@garageNum.each do |garageNum|
				get_content(garageNum.garageNum, first_start_date, first_end_date, second_start_date, second_end_date, third_start_date, third_end_date, four_start_date,four_end_date)
			end
		end
		respond_with @newrect
	end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_turn
      @turn = Turn.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def turn_params
      params.require(:turn).permit(:garage_num, :total_parking_number)
    end

		def get_content(garage_uuid, first_start_date, first_end_date, second_start_date, second_end_date, third_start_date, third_end_date, four_start_date, four_end_date)

			detailContent = {}
			@firstContent = Turn.where("garage_num = ? AND created_at >= ? AND created_at <= ?", garage_uuid, first_start_date, first_end_date).all
			@secondContent = Turn.where("garage_num = ? AND created_at >= ? AND created_at <= ?", garage_uuid, second_start_date, second_end_date).all
			@thirdContent = Turn.where("garage_num = ? AND created_at >= ? AND created_at <= ?", garage_uuid, third_start_date, third_end_date).all
			@fourContent = Turn.where("garage_num = ? AND created_at >= ? AND created_at <= ?", garage_uuid, four_start_date, four_end_date).all
			@information = Information.find_by("uuid = ?", garage_uuid)
			detailContent[:totalParking] = @information.total_parking_space
			detailContent[:firstContent] = @firstContent
			detailContent[:secondContent] = @secondContent
			detailContent[:thirdContent] = @thirdContent
			detailContent[:fourContent] = @fourContent
			@newrect.push(detailContent)
		end
end
