class AnswersController < ApplicationController
  before_action :set_answer, only: [:show, :edit, :update, :destroy]


  # GET /questions
  # GET /questions.json
  def index
    @answers = Answer.all
  end

  # GET /answer/1
  # GET /answer/1.json
  def show
  end

  # GET /answer/new
  def new
    @user_id = 1
    @quizz_id = params[:quizz_id]
    @quizz = Quizz.find(params[:quizz_id])
    @answer = Answer.new
  end

  # POST /answer
  # POST /answer.json
  def create

          # question_id = answer_params[:question].keys[0].to_i
          # choice_id = answer_params[:question].values[0].to_i
          # quizz_id = answer_params[:quizz_id] 
          saveflag = 0
          quizz_id = answer_params[:quizz_id]  
          
          answer_params[:question].each do |key,value|
            question_id = key.to_i
            choice_id = value.to_i
            
                   
          @answer = Answer.new(:question_id => question_id, :choice_id => choice_id, :user_id => 1)
            if !@answer.save 
              saveflag = 1
            end
          end
          
          respond_to do |format|
              if saveflag == 0
                  format.html { redirect_to @answer, notice: 'Resposta salva com sucesso.' }
                  format.json { render :show, status: :created, location: @answer } 
              else
                  format.html { redirect_to new_answer_path({:quizz_id => quizz_id})}
                  format.json { render json: @answer.errors, status: :unprocessable_entity }
              end
          end              
          # answer_params[:question].values.each do |question|
          #   @question_id = question.to_i
          #   @choice_id =  answer_params[@question_id]
          #   @answer = Answer.create({'question_id': @question_id, 'choice_id': @choice_id})  
          #   @answer.save
          # end
          # # @answer = Answer.new(  )
          # respond_to do |format|
          #   if @answer.save
          #     format.html { redirect_to @answer, notice: 'Resposta salva com sucesso.' }
          #     format.json { render :show, status: :created, location: @answer }
          #   else
          #     format.html { render :new }
          #     format.json { render json: @answer.errors, status: :unprocessable_entity }
          #   end
          # end  
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
      format.html { redirect_to answer_url, notice: 'A resposta foi excluída com sucesso.' }
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
      params.require(:answer).permit(:quizz_id,:question => {})
    end

end
