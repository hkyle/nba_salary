class MainController < ApplicationController
  def index
    Scraper.scrape_salaries
  end
  
  def charts
    @contracts = Contract.year(params[:year])
  end
end
