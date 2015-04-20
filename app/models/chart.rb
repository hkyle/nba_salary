class Chart
  def initialize(params)
    @year = params[:year]
    @type = params[:type]
    @teams = params[:teams]
    @contracts = Contract.year(@year)
  end
  

  
  
end