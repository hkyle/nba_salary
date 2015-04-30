class StatChart < Chart
  attr_reader :stat
  
  def initialize(params)
    super
    @stat = params[:stat].downcase
  end
  
  def self.stat_list
    list = [ {val: 'per', text: 'PER'}, {val: 'ts_pct', text: 'True Shooting %'}, {val: 'trb_pct', text: 'Rebounding %'}, {val: 'ast_pct', text: 'Assist %'}, 
             {val: 'stl_pct', text: 'Steal %'}, {val: 'blk_pct', text: 'Block %'}, {val: 'tov_pct', text: 'Turnover %'}, {val: 'usg_pct', text: 'Usage %'}, 
             {val: 'ows', text: 'Offensive Win Shares'}, {val: 'dws', text: 'Defensive Win Shares'}, {val: 'ws', text: 'Win Shares'}, {val: 'ws_48', text: 'Win Shares/48 Mins'} 
           ]
           
    list.sort_by{ |l| l[:text]}
  end
  
  def teams
      Team.all.order(:abbr)
  end
  
  def main_chart
      'scatter'
  end

end