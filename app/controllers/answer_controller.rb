class RespostaController < ApplicationController
  before_action :set_answer, only: [:show, :edit, :update, :destroy]

  # GET /answer/1
  # GET /answer/1.json
  def show
  end

  # GET /answer/new
  def new
    @question = Question.find(params["question_id"])
    @answer = Answer.new
    @answer.build_user
  end

  # POST /answer
  # POST /answer.json
  def create
    @answer = Answer.new(answer_params)

    respond_to do |format|
      if @answer.save
        format.html { redirect_to @answer, notice: 'Resposta salva com sucesso.' }
        format.json { render :show, status: :created, location: @answer }
      else
        format.html { render :new }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /answer/1
  # PATCH/PUT /answer/1.json
  def update
    respond_to do |format|
      if @answer.update(answer_params)
        format.html { redirect_to @answer, notice: 'Sua resposta foi atualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @answer }
      else
        format.html { render :edit }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /answer/1
  # DELETE /answer/1.json
  def destroy
    @answer.destroy
    respond_to do |format|
      format.html { redirect_to resposta_url, notice: 'A resposta foi excluída com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_answer
      @answer = Answer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def answer_params
      params.require(:answer).permit(:choice_id,:question_id,
       user_attributes: [:id,:name, :email])
    end

end
