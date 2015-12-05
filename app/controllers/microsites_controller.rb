require 'date'

class MicrositesController < ApplicationController
  def create
    if user_signed_in?
      @microsite = Microsite.new(microsite_params)
      @microsite.save
      redirect_to root_path, :flash => { :error => @microsite.errors.full_messages.join(', ') }
    end
  end

  def destroy
    if user_signed_in?
      @microsite = Microsite.find(params[:microsite][:id])
      @microsite.destroy
      redirect_to root_path
    end
  end

  def upload
    puts "Gets here"
    time_data_format = params[:date_format]

    if user_signed_in?
      uploaded_file = params[:file][:data]
      @file_content = uploaded_file.read
      @file_content = @file_content.tr('/', '-').split(/\r?\n/).map { |s| s.to_s.split(/\t/) }.drop(1)

      if (time_data_format == "DayMonthYear")
        begin
          ## Handle 28-12-2005 and 28/12/2005
          @file_content = @file_content.map {|time, temp| [DateTime.strptime(time, '%d-%m-%Y %H:%M').utc, temp.to_f]}
          @file_content.each { |x| Microsite.find(params[:microsite][:id]).readings.build(timestamp: x[0], temperature: x[1]).save  }
        rescue
        end
      end

      if (time_data_format == "MonthDayYear")
        begin
          ## Handle 12-28-2005 and 12/28/2005
          @file_content = @file_content.map {|time, temp| [DateTime.strptime(time, '%m-%d-%Y %H:%M').utc, temp.to_f]}
          @file_content.each { |x| Microsite.find(params[:microsite][:id]).readings.build(timestamp: x[0], temperature: x[1]).save  }
        rescue
        end
      end

      if (time_data_format == "YearMonthDay")
        begin
          ## Handle 2005-12-28 and 2005/12/28
          @file_content = @file_content.map {|time, temp| [DateTime.strptime(time, '%Y-%m-%d %H:%M').utc, temp.to_f]}
          @file_content.each { |x| Microsite.find(params[:microsite][:id]).readings.build(timestamp: x[0], temperature: x[1]).save  }
        rescue
        end
      end

      redirect_to root_path
    end
  end

  private

  def string_to_datetime(string,format="%m/%d/%Y %H:%M")
    DateTime.strptime(string, format).to_time unless string.blank?
  end

  def microsite_params
    params.require(:microsite).permit(:site, :field_lat, :field_lon, :location, :country, :state_province, :biomimic, :zone, :sub_zone, :wave_exp, :tide_height)
  end
end
