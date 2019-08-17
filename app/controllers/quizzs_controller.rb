class QuizzsController < ApplicationController
  before_action :set_quizz, only: [:show, :edit, :update, :destroy]

  # GET /quizzs
  # GET /quizzs.json
  def index
    @quizzs = Quizz.all
  end

  # GET /quizzs/1
  # GET /quizzs/1.json
  def show
  end

  # GET /quizzs/new
  def new
    @quizz = Quizz.new
    @types = Type.all
  end

  # GET /quizzs/1/edit
  def edit
    @types = Type.all
  end

  # POST /quizzs
  # POST /quizzs.json
  def create
    @quizz = Quizz.new(quizz_params)

    respond_to do |format|
      if @quizz.save
        format.html { redirect_to @quizz, notice: 'Quizz was successfully created.' }
        format.json { render :show, status: :created, location: @quizz }
      else
        format.html { render :new }
        format.json { render json: @quizz.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /quizzs/1
  # PATCH/PUT /quizzs/1.json
  def update
    respond_to do |format|
      if @quizz.update(quizz_params)
        format.html { redirect_to @quizz, notice: 'Quizz was successfully updated.' }
        format.json { render :show, status: :ok, location: @quizz }
      else
        format.html { render :edit }
        format.json { render json: @quizz.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quizzs/1
  # DELETE /quizzs/1.json
  def destroy
    @quizz.destroy
    respond_to do |format|
      format.html { redirect_to quizzs_url, notice: 'Quizz was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quizz
      @quizz = Quizz.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def quizz_params
      params.require(:quizz).permit(:description, :type_id, :image,
        tags_attributes: [:id,:description,:_destroy])
    end

end
