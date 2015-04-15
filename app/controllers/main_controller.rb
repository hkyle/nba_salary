class MainController < ApplicationController
  def index
    Scraper.scrape_salaries
  end
  
  def charts
    @contracts = Contract.year(params[:year])
    @team_data = Team.all.order(:abbr)
  
  end
end
