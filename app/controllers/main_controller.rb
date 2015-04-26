class MainController < ApplicationController
  def index
    #Scraper.scrape_stats
  end
  
  def compare_chart
    @chart = CompareChart.new(
                      {year: params[:year], teams: [params[:team1], params[:team2]]}
                      )
  end
  
  def league_chart
    @chart = LeagueChart.new(
                      {year: params[:year]}
                      )
  end
  
  def stats_chart
    @chart = StatChart.new(
                      {year: '2014-2015', stat: params[:stat]}
                      )
  end
end


