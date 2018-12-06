class LinksController < ApplicationController
    before_action :set_link, only: [:show]
    before_action :find_url, only: [:show_modified_route, :show_by_short_url]
    def index
        @links = Link.all
    end

    def new
        @link = Link.new
    end

    def create
        @link = Link.new(link_params)

        @link.save

        redirect_to show_modified_route_path(@link.short_url)
    end

    def show_by_short_url
        @link.click_count += 1
        @link.save

        long_url = @link.long_url
        if !long_url.start_with?("http://") && !long_url.start_with?("https://")
            long_url = "http://" + long_url
        end
        redirect_to long_url
    end

    def show_modified_route
        @link 

        @short_link = request.scheme + "://" + request.host + ":" + request.port.to_s + "/short-url/" + @link.short_url
    end

    private

    def find_url
        @link = Link.find_by_short_url(params[:short_url])
    end

    def set_link
        @link = Link.find(params[:id])
    end

    def link_params
        params.require(:link).permit(:long_url)
    end
end