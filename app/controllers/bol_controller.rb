class BolController < ApplicationController
  def suggestions
    @term = params[:term]
    @recommendations = Bol::Recommendations
  end
end
