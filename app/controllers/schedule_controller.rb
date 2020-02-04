require 'open-uri'

class ScheduleController < ApplicationController
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
        raise "Invalid school stage speficied." unless schoolStage.match(/^[2-4]$/)
        raise "Invalid year speficied." unless year.match(/^\d{4}$/)
        raise "Invalid month speficied." unless month.match(/^\d{2}$/)
        # Use hashrockets to get values with string
        regionIdentifier = {
            'B' => "sen",
            'C' => "pen",
            'D' => "dge",
            'E' => "ice",
            'F' => "gen",
            'G' => "dje",
            'H' => "use",
            'I' => "sje",
            'J' => "goe",
            'K' => "kwe",
            'M' => "cbe",
            'N' => "cne",
            'P' => "jbe",
            'Q' => "jne",
            'R' => "gbe",
            'S' => "gne",
            'T' => "jje",
        }
        schoolRegion = regionIdentifier[schoolCode[0, 1]]
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
