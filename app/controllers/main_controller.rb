class MainController < ApplicationController
  def index
    #Scraper.scrape_salaries
  end
  
  def compare_chart
    @chart = CompareChart.new(
                      {year: params[:year], type: 'compare', teams: [params[:team1], params[:team2]]}
                      )
  end
  
  def league_chart
    @chart = LeagueChart.new(
                      {year: params[:year], type: 'league'}
                      )
  end
end


