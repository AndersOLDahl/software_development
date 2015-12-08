class MicrositesController < ApplicationController
    def index
        # Don't include reading data by default
        @include_readings = (params["include_readings"] || 'false').casecmp('true') == 0

        respond_to do |format|
            format.json {render json: filtered_microsites}
        end
    end

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

    private

    def microsite_params
        params.require(:microsite).permit(:site, :field_lat, :field_lon, :location, :country, :state_province, :biomimic, :zone, :sub_zone, :wave_exp, :tide_height)
    end

    def filtered_microsites
        # Start with an inner join of Microsites and Readings
        microsites = Microsite.joins(:readings)

        if params.has_key? 'start_time'
            # Only show microsites with at least one reading at or after start_time, if provided
            microsites = microsites.where('readings.timestamp >= to_timestamp(?)', params['start_time'])
        end

        if params.has_key? 'end_time'
            # Only show microsites with at least one reading before end_time, if provided
            microsites = microsites.where('readings.timestamp < to_timestamp(?)', params['end_time'])
        end

        if params.has_key? 'limit'
            microsites = microsites.limit(params['limit'])

            if params.has_key? 'offset'
                microsites = microsites.offset(params['offset'])
            end
        end


        # Take just the valid filters for the microsites table
        microsite_filters = params.slice('site', 'state_province', 'country', 'biomimic', 'zone', 'sub_zone', 'wave_exp', 'tide_height')
        if !microsite_filters.empty?
            # Filter the microsites by if any filters were provided (an empty where clause would result in 0 records)
            microsites = microsites.where(microsite_filters.symbolize_keys)
        end

        if @include_readings
            # Tell ActiveRecord we will be using the reading data to improve query efficiency.
            return microsites.includes(:readings).to_json(:include => :readings)
        else
            return microsites.uniq.to_json
        end
    end
end
