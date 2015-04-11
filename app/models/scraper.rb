class Scraper
  require 'open-uri'
  
  def self.scrape_salaries()
    url = 'http://www.basketball-reference.com/contracts/players.html'
    stat_lines = []

      doc = Nokogiri::HTML(open(url))
      vals = {}
      stats = doc.xpath('//table[contains(@id, "contracts")]//tbody//tr')
      

      stats.each_with_index do |row, index|
          #only interested in the salaries for next 4 years
          if row['class'].blank?
            cols = row.search('td')[1,7].map{ |x| x.to_s.gsub(/(\<.*?\>)/,'')} #stripping everything in brackets!

             if cols[0].nil? == false #make sure we have a player name
               p = Player.find_or_create_by(name: cols[0].to_s)
               t = Team.find_or_create_by(abbr: cols[1].to_s)
               
               for i in 2..5
                 if !cols[i].blank?
                   c = Contract.find_or_create_by(year: (2012+i).to_s+'-'+(2013+i).to_s, salary: cols[i].tr!('$,',''), player_id: p.id, team_id: t.id)
                 end
               end
             end
           end
          end
    end
    
end