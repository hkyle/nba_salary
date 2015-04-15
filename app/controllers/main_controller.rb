class MainController < ApplicationController
  def index
    #Scraper.scrape_salaries
  end
  
  def charts
    @contracts = Contract.year(params[:year])
    @team_data = Team.all.order(:abbr)
=begin
    @chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(:text => "Salary By Team")
      f.xAxis(:categories => @team_data.map{|i| i.abbr})
      f.series(:name => "Salary", :yAxis => 0, :data => @team_data.map{|i| i.contracts.year(params[:year]).sum(:salary).floor }, :drilldown => 'subdept')
      f.yAxis [
        {:title => {:text => "Salary $"} }
      ]
    
      f.legend(:align => 'right', :verticalAlign => 'top', :y => 75, :x => -50, :layout => 'vertical',)
      f.chart({:defaultSeriesType=>"column"})
      
      f.drilldown(series: {
        name:"Dept. Score",
        id: 'subdept',
        data: [
        ["One", 1000],
        ["Two", 20000000],
        ["Three", 300000]
      ]
        })

    end
=end
  end
end
