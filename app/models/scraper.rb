class Scraper
  require 'open-uri'
  
  def self.get_disp_html(html_in)
    # takes one line of HTML like "<th data-stat="y1" align="CENTER"  class="tooltip" >2014-15</th>"
    # and returns what is between brackets, "2014-15"
    html_in.to_s.gsub(/(\<.*?\>)/,'')
  end
  
    def self.box_scraper(game_ids, game=nil)
    base_url = "http://www.basketball-reference.com"
    stat_lines = []
    
    [*game_ids].each do |gid|
      url = base_url + gid
      
      doc = Nokogiri::HTML(open(url))

      home_basic_stats = doc.xpath('//table[contains(@id, "'+game.home_team.abbr+'_basic")]//tbody//tr[@class=""]') 
      away_basic_stats = doc.xpath('//table[contains(@id, "'+game.away_team.abbr+'_basic")]//tbody//tr[@class=""]')
      
      home_adv_stats = doc.xpath('//table[contains(@id, "'+game.home_team.abbr+'_advanced")]//tbody//tr[@class=""]') 
      away_adv_stats = doc.xpath('//table[contains(@id, "'+game.away_team.abbr+'_advanced")]//tbody//tr[@class=""]') 

      date = doc.xpath('//table[contains(@class, "border_gray")]//td[contains(@class, "small_text")]')
      date = get_disp_html(date.to_s.split('<br>')[0])#.gsub(/<\/?[^>]*>/,'')
      game_date = DateTime.strptime(date, "%I:%M %p, %B %d, %Y")
      
      away_record = get_disp_html(doc.xpath('//*[@id="page_content"]/table/tr/td/div[2]/div[1]/h2[1]')).to_s.match(/\d+\-\d+/).to_s
      home_record = get_disp_html(doc.xpath('//*[@id="page_content"]/table/tr/td/div[2]/div[5]/h2[1]')).to_s.match(/\d+\-\d+/).to_s
      
      attend = get_disp_html(doc.xpath('//*[@id="page_content"]/table/tr[1]/td[1]/div[2]/table[1]/tr[3]/td[2]')).gsub!(',','')
      officials = get_disp_html(doc.xpath('//*[@id="page_content"]/table/tr[1]/td[1]/div[2]/table/tr[2]/td[2]')).to_s.strip

      if !get_disp_html(doc.xpath('//*[@id="page_content"]/table/tr[1]/td[1]/div[1]/div[1]/table[1]/tr[1]/td[1]/strong')).to_s.blank?
        playoffs = true
      else
        playoffs = false
      end

      game.update!(game_date: game_date, home_wins: home_record.split('-')[0], home_losses: home_record.split('-')[1],
                   away_wins: away_record.split('-')[0], away_losses: away_record.split('-')[1], attendance: attend,
                   officials: officials, playoff: playoffs
                   )

      
      self.insert_box_stats(basic_stats: home_basic_stats,
                             adv_stats: home_adv_stats,
                             team: game.home_team,
                             game: game)
                             
      self.insert_box_stats(basic_stats: away_basic_stats,
                             adv_stats: away_adv_stats,
                             team: game.away_team,
                             game: game)
    
    end
  end
  
  def self.daily_box_gids(month, day, year=2015)
    url = "http://www.basketball-reference.com/boxscores/index.cgi?month="+month.to_s+"&day="+day.to_s+"&year="+year.to_s
    doc = Nokogiri::HTML(open(url))

    games = doc.xpath('//div[@id="boxes"]/table/tr/td/table')
    
    [*games].each do |game|                     
      away_team_abbr = game.xpath('./tr[1]/td[1]/table/tr[1]/td[1]').to_s.match(/[A-Z]{3}/).to_s #away team abbr
      a_score = get_disp_html(game.xpath('./tr[1]/td[1]/table/tr[1]/td[2]')) #away team score
      home_team_abbr = game.xpath('./tr[1]/td[1]/table/tr[2]/td[1]').to_s.match(/[A-Z]{3}/).to_s #home team abbr
      h_score = get_disp_html(game.xpath('./tr[1]/td[1]/table/tr[2]/td[2]')) #home team score
      game_id = game.xpath('./tr[1]/td[1]/table/tr[1]/td[3]/a/@href').first.value
      
      if get_disp_html(game.xpath('./tr[2]/td[1]/table/tr[1]/td[6]')) == 'OT'
        ot = true
      else
        ot = false
      end

      g = Game.where( home_team_id: Team.find_or_create_by(abbr: home_team_abbr), away_team_id: Team.find_or_create_by(abbr: away_team_abbr),
                              home_score: h_score, away_score: a_score,
                              bbr_gid: game_id, overtime: ot).first_or_create
                              
      self.box_scraper(game_id, g)
    end
    
  end
  
  def self.scrape_adv_stats(year)
    url = 'http://www.basketball-reference.com/leagues/NBA_'+year.to_s+'_advanced.html'

      doc = Nokogiri::HTML(open(url))
      stats = doc.xpath('//table[contains(@id, "advanced")]//tbody//tr')

      stats.each_with_index do |row, index|
          if row['class'] == 'full_table'
            player_url = row.xpath('./td/a/@href').first.value
            print player_url
            cols = row.search('td').map{ |x| x.text }
            print cols
            #0 => player name, 1 => pos, 2 => age, 3 => team, 4 => games played
            #5 => minutes, 6 => PER, 7 => TS%, 8 => 3PAr, 9 => FTr, 10 => ORB%
            #11 => DRB%, 12 => TRB%, 13 => AST%, 14 => STL%, 15 => BLK%
            #16 => TOV%, 17 => USG%, 19 => OWS, 20 => DWS, 21 => WS, 22 => WS/48
            #24 => OBPM, 25 => DBPM, 26 => BPM, 27 => VORP
            # empty columns - 19, 24

            p = Player.find_or_create_by(name: cols[1].to_s, bbr_pid: player_url)
            
            if !p.nil?
              #change blank columns to 0
              cols.map!{|e| e.blank? ? 0 : e }
              
              s = SeasonStat.find_or_create_by(year: (year-1).to_s+'-'+year.to_s, player_id: p.id, pos: cols[1], age: cols[2], games: cols[4],
                  mp: cols[5], per: cols[6], ts_pct: cols[7], three_par: cols[8], ftr: cols[9], orb_pct: cols[10], drb_pct: cols[11],
                  trb_pct: cols[12], ast_pct: cols[13], stl_pct: cols[14], blk_pct: cols[15], tov_pct: cols[16], usg_pct: cols[17],
                  ows: cols[19], dws: cols[20], ws: cols[21], ws_48: cols[22], obpm: cols[24], dbpm: cols[25], bpm: cols[26], vorp: cols[27]
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

      stats[0..0].each_with_index do |row, index|
          #only interested in the salaries for next 4 years
          if row['class'].blank?
            cols = row.search('td')[0,6].map{ |x| x.text } #stripping everything in brackets!
            player_url = row.xpath('./td/a/@href').first.value

             if cols[0].nil? == false #make sure we have a player name
               p = Player.find_or_create_by(name: cols[0].to_s, bbr_pid: player_url)
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
  
  def self.insert_box_stats(args)
    args[:basic_stats] = args[:basic_stats].to_a.sort!{ |a, b| a.xpath('./td//a').text <=> b.xpath('./td//a').text}
    args[:adv_stats] = args[:adv_stats].to_a.sort!{ |a, b| a.xpath('./td//a').text <=> b.xpath('./td//a').text}
    
    args[:basic_stats].each_with_index do |row, index|
            cols = row.search('td').map{ |x| x.to_s.gsub(/(\<.*\>(?!$)|\<\/td\>$)/,'')} #.map(&:to_s) #stripping nil values

            name = row.search('td/a/text()').map(&:to_s)
            player_url = row.xpath('./td/a/@href').first.value

            #don't want stats for these cases
            if name.nil? || cols[1] == 'Did Not Play'
               next
            end
            
            adv_cols = args[:adv_stats][index].search('td').map{ |x| x.to_s.gsub(/(\<.*\>(?!$)|\<\/td\>$)/,'')}
            name_check = args[:adv_stats][index].search('td/a/text()').map(&:to_s)

            if name != name_check
              puts args[:game].bbr_gid
              puts name
              puts name_check
              raise 'Basic and Advanced Stats not synced!'
            end
            
            s = Boxscore.find_or_create_by(
              player: Player.find_or_create_by(name: name[0].to_s, bbr_pid: player_url),
              game: args[:game],
              player_name: name[0],
              minutes: cols[1].split(':')[0],
              seconds: cols[1].split(':')[1])
              
            s.update!(
              fgm: cols[2],
              fga: cols[3],
              fg_pct: cols[4].presence,
              tpm: cols[5],
              tpa: cols[6],
              tp_pct: cols[7].presence,
              ftm: cols[8],
              fta: cols[9],
              ft_pct: cols[10].presence,
              orb: cols[11],
              drb: cols[12],
              trb: cols[13],
              assists: cols[14],
              steals: cols[15],
              blocks: cols[16],
              tov: cols[17],
              pf: cols[18],
              points: cols[19],
              plus_minus: cols[20],
              team: args[:team],
              ts_pct: adv_cols[2].presence,
              efg_pct: adv_cols[3].presence,
              three_par: adv_cols[4].presence,
              ftr: adv_cols[5].presence,
              orb_pct: adv_cols[6].presence,
              drb_pct: adv_cols[7].presence,
              trb_pct: adv_cols[8].presence,
              ast_pct: adv_cols[9].presence,
              stl_pct: adv_cols[10].presence,
              blk_pct: adv_cols[11].presence,
              tov_pct: adv_cols[12].presence,
              usg_pct: adv_cols[13].presence,
              o_rtg: adv_cols[14],
              d_rtg: adv_cols[15]
              )
    end
  end
    
end