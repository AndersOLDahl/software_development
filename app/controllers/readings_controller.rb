class ReadingsController < ApplicationController
   
    def index
        respond_to do |format|
            format.csv {render_csv}
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
