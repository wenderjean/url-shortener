module UrlsHelper
  def convert_to_external_path(url)
    "http://#{url}"
  end
end
