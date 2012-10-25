class SmsController < ApplicationController
  rescue_from InvalidSmsGrammarError, with: :handle_invalid_query

  def inbound
    cuisine, zip = parse_twilio_inbound_message
    restaurants = YelpService.find_restaurants(cuisine, zip)
    render :xml => TwilioResponder.respond(restaurants)
  end

  private

  def parse_twilio_inbound_message
    raw_params = params[:Body].split
    raise InvalidSmsGrammarError.new unless raw_params.size >= 2
    zip = raw_params.last
    raise InvalidSmsGrammarError.new unless /^\d{5}$/.match(zip)
    cuisine = raw_params[0..(raw_params.size - 2)].join(' ')
    return cuisine, zip
  end

  def handle_invalid_query
    render :xml => TwilioResponder.respond_to_unrecognized_input
  end

end
