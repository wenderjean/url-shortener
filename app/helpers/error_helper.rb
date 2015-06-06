module ErrorHelper
  def get_errors(resource)
    errors = resource.errors.full_messages
    content_tag(:div, class: 'alert alert-danger') { errors.first } if errors.any?
  end
end
