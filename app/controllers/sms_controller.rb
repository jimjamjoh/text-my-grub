class SmsController < ApplicationController
  def inbound
    begin
      cuisine, zip = params[:Body].split
      $stderr.puts "cuisine --> #{cuisine}"
      $stderr.puts "zip --> #{zip}"
      render :xml => SmsResponse.new("buffalo is #{YelpService.buffalo}").to_xml
    rescue Exception => e
      render :xml => SmsResponse.unrecognized_input.to_xml
    end
  end
end
