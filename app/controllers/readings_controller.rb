class ReadingsController < ApplicationController

    def index
        # Include microsite data by default
        @include_microsites = (params["include_microsites"] || 'true').casecmp('true') == 0

        respond_to do |format|
            format.csv {render_csv}
        end
    end

    def upload
      time_data_format = params[:date_format]

      if user_signed_in?
        if (time_data_format == "DayMonthYear")
          begin
            uploaded_file = params[:file][:data]
            @file_content = uploaded_file.read
            @file_content = @file_content.tr('/', '-').split(/\r?\n/).map { |s| s.to_s.split(/\t/) }.drop(1)

            ## Handle 28-12-2005 and 28/12/2005
            @file_content = @file_content.map {|time, temp| [DateTime.strptime(time, '%d-%m-%Y %H:%M').utc, temp.to_f]}
            @file_content.each { |x| Microsite.find(params[:microsite_id]).readings.build(timestamp: x[0], temperature: x[1]).save  }
            redirect_to root_path
          rescue
            redirect_to root_path, :flash => { :error => "DayMonthYear format did not work with the given file." }
          end
        elsif (time_data_format == "MonthDayYear")
          begin
            uploaded_file = params[:file][:data]
            @file_content = uploaded_file.read
            @file_content = @file_content.tr('/', '-').split(/\r?\n/).map { |s| s.to_s.split(/\t/) }.drop(1)

            ## Handle 12-28-2005 and 12/28/2005
            @file_content = @file_content.map {|time, temp| [DateTime.strptime(time, '%m-%d-%Y %H:%M').utc, temp.to_f]}
            @file_content.each { |x| Microsite.find(params[:microsite_id]).readings.build(timestamp: x[0], temperature: x[1]).save  }
            redirect_to root_path
          rescue
            redirect_to root_path, :flash => { :error => "MonthDayYear format did not work with the given file." }
          end
        elsif (time_data_format == "YearMonthDay")
          begin
            uploaded_file = params[:file][:data]
            @file_content = uploaded_file.read
            @file_content = @file_content.tr('/', '-').split(/\r?\n/).map { |s| s.to_s.split(/\t/) }.drop(1)

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

        response.status = :ok

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
            # Write the header line to the CSV
            y << Reading.csv_header(@include_microsites).to_s

            # Iterate over matching readings. find_each is used to retrieve records in batches to save memory.
            filtered_readings.find_each do |reading|
                y << reading.to_csv_row(@include_microsites).to_s
            end
        end
    end

    def filtered_readings
        # Start with an inner join of Readings and Microsites
        readings = Reading.joins(:microsite)

        if params.has_key? 'start_time'
            # Only show readings at or after start_time, if provided
            readings = readings.where('timestamp >= to_timestamp(?)', params["start_time"])
        end

        if params.has_key? 'end_time'
            # Only show readings before end_time, if provided
            readings = readings.where('timestamp < to_timestamp(?)', params["end_time"])
        end

        # Take just the valid filters for the microsites table
        microsite_filters = params.slice('site', 'state_province', 'country', 'biomimic', 'zone', 'sub_zone', 'wave_exp', 'tide_height')
        if !microsite_filters.empty?
            # Filter the readings by microsites if any remain (an empty where clause would result in 0 records)
            readings = readings.where(microsites: microsite_filters)
        end

        if @include_microsites
            # Tell ActiveRecord we will be using the microsite data to improve query efficiency.
            readings = readings.includes(:microsite)
        end

        return readings
    end
end
