require 'open-uri'

class ScheduleController < ApplicationController
    include NeisHelper

    def index
        render json: {status: true}
    end

    def show
        schoolCode = params[:schoolCode]
        schoolStage = params[:schoolStage]
        year = params[:year]
        month = params[:month]
        begin
            render json: {status: true, schoolCode: schoolCode, schoolStage: schoolStage, year: year, month: month, schedule: fetch(schoolCode, schoolStage, year, month)}
        rescue => e
            render json: {status: false, message: e.to_s}    
        end
    end

    private
    
    def fetch(schoolCode, schoolStage, year, month)
        # params validation
        raise "Invalid school code specified." unless schoolCode.match(/[A-Z]\d{9}/)
        raise "Invalid school stage specified." unless schoolStage.match(/^[2-4]$/)
        raise "Invalid year specified." unless year.match(/^\d{4}$/)
        raise "Invalid month specified." unless month.match(/^\d{2}$/)
        schoolRegion = get_identifier(schoolCode)
        document = Nokogiri::HTML(open("https://stu.#{schoolRegion}.go.kr/sts_sci_sf01_001.do?schulCode=#{schoolCode}&schulCrseScCode=#{schoolStage}&schulKndScCode=0#{schoolStage}&ay=#{year}&mm=#{month}"))
        parsed = document.css('.tbl_calendar tbody tr td div')
        data = []
        parsed.each do |p|
            diff = p.to_s.gsub(/&amp;/, '&').split('<br>', 2)
            date = Nokogiri::HTML(diff[0]).text.strip
            content = Nokogiri::HTML(diff[1]).css('a').inner_html.scan(/<strong>(.*?)<\/strong>/).flatten
            unless (date.empty?)
                data << {
                    date: date.to_i,
                    content: content.empty? ? nil : content
                }
            end
        end
        return data
    end
end
