require "national_rail/version"

require 'savon'

module NationalRail
  
  class Timetable
    
    def self.departures(token, crs)
      get_data(token, "Departure", :std, crs)
    end
    
    def self.arrivals(token, crs)
      get_data(token, "Arrival", :sta, crs)
    end
    
    private
    
    def self.get_data(token, request_type, time_key, station_code)
  
      begin
        response_type = request_type.downcase
  
        client = Savon::Client.new do
          wsdl.document = "http://realtime.nationalrail.co.uk/LDBWS/wsdl.aspx"
        end

        response = client.request "http://thalesgroup.com/RTTI/2012-01-13/ldb/Get#{request_type}Board" do

          namespaces = {
            "xmlns:soap" => "http://schemas.xmlsoap.org/soap/envelope/",
            "xmlns:xsi" => "http://www.w3.org/2001/XMLSchema-instance",
            "xmlns:xsd" => "http://www.w3.org/2001/XMLSchema"
          }
  
          soap.xml do |xml|
            xml.soap(:Envelope, namespaces) do |xml|
              xml.soap(:Header) do |xml|
                xml.AccessToken do |xml|
                  xml.TokenValue(token) 
                end
              end
              xml.soap(:Body) do |xml|
                xml.tag!("Get#{request_type}BoardRequest", {xmlns: "http://thalesgroup.com/RTTI/2012-01-13/ldb/types"}) do |xml|
                  xml.numRows(10)
                  xml.crs(station_code)
                end
              end
            end
          end
        end
  
        services = response.body["get_#{response_type}_board_response".to_sym]["get_#{response_type}_board_result".to_sym][:train_services]
        return [].to_json unless services
        services = services[:service]
        return [].to_json unless services
  
        services = [services] if services.is_a?(Hash)

        services.map do |service|
          {
            origin: service[:origin][:location][:location_name],
            origin_crs: service[:origin][:location][:crs],
            destination: service[:destination][:location][:location_name],
            destination_crs: service[:destination][:location][:crs],
            time: service[time_key]
          }
        end
      rescue
        p $!
        {}
      end
    end
  end
end
