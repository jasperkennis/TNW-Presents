class BolController < ApplicationController
  def suggestions
    @term = params[:term]
    @product = Bol.search(@term).limit(1)
    @recommendations = Bol.recommendations @product.first.id
  end
end
