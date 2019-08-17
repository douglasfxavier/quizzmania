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
    @quizz = @answer.question.quizz
    @answers = Quizz.joins(
      'JOIN questions ON questions.quizz_id = quizzs.id
       JOIN answers ON answers.question_id = questions.id
       JOIN choices ON answers.choice_id = choices.id'
      ).where('user_id= ? and quizz_id = ?',current_user.id,@quizz.id).uniq

    @map = Hash.new

    @answers[0].questions.each do |question|
      @choice = question.answers[0].choice

      if @map[@choice.tag.id].nil?
       @map[@choice.tag.id] = 0
      end
      @map[@choice.tag.id] = @map[@choice.tag.id] + 1   
    end

    aux = 0 
    @tag_id = 0
    @map.each do |key,value|
      if value > aux
        @tag_id = key
      end
    end

    @tagresult = Tag.find(@tag_id)
  end

  # GET /answer/new
  def new
    @user_id = current_user
    @quizz_id = params[:quizz_id]
    @quizz = Quizz.find(params[:quizz_id])
    @answer = Answer.new
  end

  # POST /answer
  # POST /answer.json
  def create

         quizz_id = answer_params[:quizz_id]  
                       
          def save_answers         
            answer_params[:questions].each do |key,value|
              question_id = key.to_i
              choice_id = value.to_i            
              @answer = Answer.new(:question_id => question_id, :choice_id => choice_id, :user_id => current_user.id)
              if !@answer.save 
                return false
              end              
            end
            return true
          end

          respond_to do |format|
              if save_answers() == true 
                  format.html { redirect_to @answer, notice: 'Resposta salva com sucesso.' }
                  format.json { render :show, status: :created, location: @answer } 
              else
                  format.html { redirect_to new_answer_path({:quizz_id => quizz_id})}
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
      params.require(:answer).permit(:quizz_id,:questions => {})
    end

end
