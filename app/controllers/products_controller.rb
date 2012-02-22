class ProductsController < ApplicationController
  
  def index
    render :json => params
  end
  
  def show
    render :text => 'I am show'
  end
  
end
