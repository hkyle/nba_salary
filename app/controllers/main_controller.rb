class MainController < ApplicationController
  def index
    Scraper.scrape_salaries
  end
end
