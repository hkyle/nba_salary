class Chart
  attr_reader :teams_arr
  
  def initialize(params)
    @year = params[:year]
    @teams_arr = params[:teams]
    @contracts = Contract.year(@year)
  end
  

  
  
end