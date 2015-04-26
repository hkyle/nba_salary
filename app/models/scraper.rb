class Scraper
  require 'open-uri'
  
  def self.get_disp_html(html_in)
    # takes one line of HTML like "<th data-stat="y1" align="CENTER"  class="tooltip" >2014-15</th>"
    # and returns what is between brackets, "2014-15"
    html_in.to_s.gsub(/(\<.*?\>)/,'')
  end
  
  def self.scrape_stats()
    url = 'http://www.basketball-reference.com/leagues/NBA_2015_advanced.html'

      doc = Nokogiri::HTML(open(url))
      stats = doc.xpath('//table[contains(@id, "advanced")]//tbody//tr')

      stats.each_with_index do |row, index|
          if row['class'] == 'full_table'
            cols = row.search('td').map{ |x| get_disp_html(x)} #stripping everything in brackets!
            
            #0 => rownum, 1 => player name, 2 => pos, 3 => age, 4 => team, 5 => games played
            #6 => minutes, 7 => PER, 8 => TS%, 9 => 3PAr, 10 => FTr, 11 => ORB%
            #12 => DRB%, 13 => TRB%, 14 => AST%, 15 => STL%, 16 => BLK%
            #17 => TOV%, 18 => USG%, 20 => OWS, 21 => DWS, 22 => WS, 23 => WS/48
            #25 => OBPM, 26 => DBPM, 27 => BPM, 28 => VORP
            # empty columns - 19, 24

            p = Player.find_or_create_by(name: cols[1].to_s)
            
            if !p.nil?
              #change blank columns to 0
              cols.map!{|e| e.blank? ? 0 : e }
              
              s = AdvancedStat.find_or_create_by(year: '2014-2015', player_id: p.id, pos: cols[2], age: cols[3], games: cols[5],
                  mp: cols[6], per: cols[7], ts_pct: cols[8], three_par: cols[9], ftr: cols[10], orb_pct: cols[11], drb_pct: cols[12],
                  trb_pct: cols[13], ast_pct: cols[14], stl_pct: cols[15], blk_pct: cols[16], tov_pct: cols[17], usg_pct: cols[18],
                  ows: cols[20], dws: cols[21], ws: cols[22], ws_48: cols[23], obpm: cols[25], dbpm: cols[26], bpm: cols[27], vorp: cols[28]
                  )
            end
            
            
            
          end
      end
  end
  
  def self.scrape_salaries()
    url = 'http://www.basketball-reference.com/contracts/players.html'

      doc = Nokogiri::HTML(open(url))
      stats = doc.xpath('//table[contains(@id, "contracts")]//tbody//tr')
      
      #this will get the year header, e.g. "2014-15", and split that out to only the first year (2014)
      first_year = get_disp_html(doc.xpath('//table[contains(@id, "contracts")]//tbody//tr//th[contains(@data-stat, "y1")]').first).split('-')[0].to_i

      stats.each_with_index do |row, index|
          #only interested in the salaries for next 4 years
          if row['class'].blank?
            cols = row.search('td')[1,7].map{ |x| get_disp_html(x)} #stripping everything in brackets!

             if cols[0].nil? == false #make sure we have a player name
               p = Player.find_or_create_by(name: cols[0].to_s)
               t = Team.find_or_create_by(abbr: cols[1].to_s)
               
               #check if each element (year) has salary given
               for i in 2..5 
                 if !cols[i].blank?
                   c = Contract.find_or_create_by(year: (first_year - 2 + i).to_s+'-'+(first_year - 1 + i).to_s, salary: cols[i].tr!('$,',''), player_id: p.id, team_id: t.id)
                 end
               end
             end
             
          end
      end
  end
    
end