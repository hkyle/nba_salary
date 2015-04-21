class Chart
  def initialize(params)
    @year = params[:year]
    @teams = params[:teams]
    @contracts = Contract.year(@year)
  end
  

  
  
end