class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  # GET /questions
  # GET /questions.json
  def index
    @questions = Question.all
  end

  # GET /questions/1
  # GET /questions/1.json
  def show    
  end

  # GET /questions/new
  def new
    @question = Question.new
    @quizz_id = params['quizzid']

    if @quizz_id
      @quizz = Quizz.find(@quizz_id)
      @numbertags = @quizz.tags.size
    end
  end

  # GET /questions/1/edit
  def edit
    @quizz_id = params['quizzid']
    @quizz = Quizz.find(params['quizzid'])
  end


  def save_question_choices   
    quizz_id = question_params[:quizz_id]  
    question_description = question_params[:description]       
    @question = Question.new(:description => question_description, :quizz_id => quizz_id)
    if !@question.save 
      return false
    end  
    question_id = @question.id
    question_params[:choices].each do |key,value|
      tag_id = key.to_i
      choice_description = value
      @choice = Choice.new(:description => choice_description, :question_id => question_id, :tag_id => tag_id)
      if !@choice.save
        return false
      end
    end
    return true  
  end  


  # POST /questions
  # POST /questions.json

  def create 
    
    respond_to do |format|
      if save_question_choices() == true
        format.html { redirect_to @question, notice: 'Question criada com sucesso.' }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render root_path }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_question_choices   
    id = params[:id]
    quizz_id = question_params[:quizz_id]  
    question_description = question_params[:description]       
    
    if !@question.update(:id => id, :description => question_description, :quizz_id => quizz_id) 
      return false
    end
    question_id = @question.id  
    question_params[:choices].each do |key,value|
      tag_id = key.to_i
      choice_description = value
      @choice = Choice.find_by(question_id: question_id, tag_id: tag_id)  
      if !@choice.update(:description => choice_description)
        return false
      end
    end
    return true  
  end  

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
 
    respond_to do |format|
      if update_question_choices() == true
        format.html { redirect_to @question, quizzid: @quizz_id, notice: 'Question atualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy

    @quizz_id = @question.quizz.id
    @question.destroy

    respond_to do |format|
      format.html { redirect_to quizz_path(@quizz_id), notice: 'Question excluída com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:description,:quizz_id, :choices => {})
    end
end