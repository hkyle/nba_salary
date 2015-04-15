class Scraper
  require 'open-uri'
  
  def self.get_disp_html(html_in)
    # takes one line of HTML like "<th data-stat="y1" align="CENTER"  class="tooltip" >2014-15</th>"
    # and returns what is between brackets, "2014-15"
    html_in.to_s.gsub(/(\<.*?\>)/,'')
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