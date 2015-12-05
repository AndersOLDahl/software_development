class ReadingsController < ApplicationController

    def index
        respond_to do |format|
            format.csv {render_csv}
        end
    end

    def upload
      time_data_format = params[:date_format]

      if user_signed_in?
        uploaded_file = params[:file][:data]
        @file_content = uploaded_file.read
        @file_content = @file_content.tr('/', '-').split(/\r?\n/).map { |s| s.to_s.split(/\t/) }.drop(1)

        if (time_data_format == "DayMonthYear")
          begin
            ## Handle 28-12-2005 and 28/12/2005
            @file_content = @file_content.map {|time, temp| [DateTime.strptime(time, '%d-%m-%Y %H:%M').utc, temp.to_f]}
            @file_content.each { |x| Microsite.find(params[:microsite_id]).readings.build(timestamp: x[0], temperature: x[1]).save  }
            redirect_to root_path
          rescue
            redirect_to root_path, :flash => { :error => "DayMonthYear format did not work with the given file." }
          end
        elsif (time_data_format == "MonthDayYear")
          begin
            ## Handle 12-28-2005 and 12/28/2005
            @file_content = @file_content.map {|time, temp| [DateTime.strptime(time, '%m-%d-%Y %H:%M').utc, temp.to_f]}
            @file_content.each { |x| Microsite.find(params[:microsite_id]).readings.build(timestamp: x[0], temperature: x[1]).save  }
            redirect_to root_path
          rescue
            redirect_to root_path, :flash => { :error => "MonthDayYear format did not work with the given file." }
          end
        elsif (time_data_format == "YearMonthDay")
          begin
            ## Handle 2005-12-28 and 2005/12/28
            @file_content = @file_content.map {|time, temp| [DateTime.strptime(time, '%Y-%m-%d %H:%M').utc, temp.to_f]}
            @file_content.each { |x| Microsite.find(params[:microsite_id]).readings.build(timestamp: x[0], temperature: x[1]).save  }
            redirect_to root_path
          rescue
            redirect_to root_path, :flash => { :error => "YearMonthDay format did not work with the given file." }
          end
        else
            redirect_to root_path
        end
      end
    end

    private

    def render_csv
        set_file_headers
        set_streaming_headers

        response.status=200

        self.response_body = csv_lines
    end

    def set_file_headers
        file_name = "readings.csv"
        headers["Content-Type"] = "text/csv"
        headers["Content-disposition"] = "attachment; filename=\"#{file_name}\""
    end


    def set_streaming_headers
        headers['X-Accel-Buffering'] = 'no'
        headers["Cache-Control"] ||= "no-cache"
        headers.delete("Content-Length")
    end

    def csv_lines
        Enumerator.new do |y|
            y << Reading.csv_header.to_s

            Reading.all.each do |reading|
                y << reading.to_csv_row.to_s
            end
        end
    end
end
