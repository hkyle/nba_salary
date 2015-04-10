class MainController < ApplicationController
  def index
    
  end
  
  def charts
    @contracts = Contract.year(params[:year])
  end
end
