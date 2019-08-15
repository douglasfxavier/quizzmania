class HomeController < ApplicationController
  def index
  	@quizzs = Quizz.all
  end
end
