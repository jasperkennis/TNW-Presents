class BolController < ApplicationController
  def suggestions
    @term = params[:term]
    @product = Bol.search(@term).limit(1)
    @recommendations = Bol.recommendations( @product.first.id ).limit(4)
    
    respond_to do |format|
      format.json  { render :json => @recommendations }
    end
  end
end
