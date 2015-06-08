class UrlsController < ApplicationController
  before_action :set_url, only: [:show, :destroy]
  before_action :require_authentication, only: [:index, :show, :destroy]

  respond_to :html

  def index
    @urls = current_user.urls
    respond_with(@urls)
  end

  def show
    respond_with(@url)
  end

  def new
    @url = Url.new
    respond_with(@url)
  end

  def create
    @url = get_url_by_current_user
    location = urls_path
    if user_signed_in?
      @url.save
    else
      if @url.valid?
        @url.hash
        set_item_in_temporal_session(@url)
        location = new_url_path
      end
    end

    respond_with(@url, :location => location)
  end

  def destroy
    @url = current_user.urls.find(params[:id])
    @url.destroy
    respond_with(@url)
  end

  private
    def set_url
      @url = Url.find(params[:id])
    end

    def url_params
      params.require(:url).permit(:origin)
    end

    def get_session_assign
      request.remote_ip
    end

    def get_url_by_current_user
      user_signed_in? ? current_user.urls.build(url_params) : Url.new(url_params)
    end

    def get_temporal_session
      temp = YAML.load(session[get_session_assign]) if session[get_session_assign]
      temp ||= []
    end

    def set_item_in_temporal_session(item)
      temp = get_temporal_session
      temp << item
      session[get_session_assign] = temp.to_yaml
    end
end
