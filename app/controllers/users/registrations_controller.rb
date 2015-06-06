class Users::RegistrationsController < Devise::RegistrationsController

  # POST /resource
  def create
    super do |resource|
      process_urls do |url|
        temp = resource.urls.build({ :origin => url.origin, :user_id => resource.id })
        temp.save
      end
    end
  end

  private

  def process_urls
    get_session.each { |url| yield(url) }
    session.delete(request.remote_ip)
  end

  def get_session
    session_exists? ? YAML.load(session[request.remote_ip]) : []
  end

  def session_exists?
    session[request.remote_ip]
  end
end
