require 'httparty'
 
class Stock < ApplicationRecord
    has_many :user_stocks
    has_many :users, through: :user_stocks
    
    validates :ticker, presence: true, uniqueness: true
    
    # Class method to lookup stock by ticker symbol

    def self.company_lookup(ticker_symbol)
        begin
            api_key = Rails.application.credentials.alphavantage[:api_key]
            response = HTTParty.get("https://www.alphavantage.co/query?function=OVERVIEW&symbol=#{ticker_symbol}&apikey=#{api_key}")
            
            if response.code == 200 && response.parsed_response['Name']
                response.parsed_response['Name']
            else
                Rails.logger.warn "Company lookup failed: #{response.code} - #{response.parsed_response}"
                nil
            end
        rescue HTTParty::Error => e
            Rails.logger.error "HTTParty error in company_lookup: #{e.message}"
            nil
        rescue StandardError => e
            Rails.logger.error "Unexpected error in company_lookup: #{e.message}"
            nil
        end
    end

    def self.new_lookup(ticker_symbol)
        begin
            #api_key = Rails.application.credentials.alphavantage[:api_key]
            api_key = "demo"
            raise "API key not found" if api_key.blank?
            
            url = "https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=#{ticker_symbol}&apikey=#{api_key}"
            response = HTTParty.get(url)
          
            if response.code == 200 && response.parsed_response['Global Quote']
                # Get company name from separate API call
                company_name = company_lookup(ticker_symbol)
                
                stock = {
                    ticker: ticker_symbol.upcase,
                    name: company_name || "Company name not found",
                    last_price: response.parsed_response['Global Quote']['05. price']
                }

                puts "Stock lookup successful: #{stock}"
                return stock
            else
                puts "API Error: #{response.code} - #{response.parsed_response}"
                Rails.logger.warn "Stock lookup failed: #{response.code} - #{response.parsed_response}"
                nil
            end
        rescue HTTParty::Error => e
            Rails.logger.error "HTTParty error in new_lookup: #{e.message}"
            puts "Network error: #{e.message}"
            nil
        rescue JSON::ParserError => e
            Rails.logger.error "JSON parsing error: #{e.message}"
            puts "Invalid JSON response: #{e.message}"
            nil
        rescue StandardError => e
            Rails.logger.error "Unexpected error in new_lookup: #{e.message}"
            puts "Unexpected error: #{e.message}"
            nil
        end
    end

    def self.check_db(ticker_symbol)
        puts "Checking database for ticker: #{ticker_symbol}"
        where(ticker: ticker_symbol).first
    end
end