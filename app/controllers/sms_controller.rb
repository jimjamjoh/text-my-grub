class SmsController < ApplicationController
  rescue_from InvalidSmsGrammarError, with: :handle_invalid_query

  def inbound
    cuisine, zip = parse_sms_query
    restaurants = YelpService.find_restaurants(cuisine, zip)
    render :xml => xml_response(smsify(restaurants))
  end

  private

  def parse_sms_query
    cuisine, zip = params[:Body].split
    raise InvalidSmsGrammarError.new if (cuisine.nil? || zip.nil?)
    return cuisine, zip
  end

  def handle_invalid_query
    render :xml => xml_response(SmsResponse.unrecognized_input)
  end

  def smsify(service_responses)
    smses = []
    service_responses.each {|service_response| smses << SmsResponse.new(service_response)}
    smses
  end

  def xml_response(sms_responses)
    sms_xml = ''
    [sms_responses].flatten.each {|sms_response| sms_xml += sms_response.to_xml}
    "<Response>#{sms_xml}</Response>"
  end

end
