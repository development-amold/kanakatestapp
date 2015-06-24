module DeviseHelper
  def devise_error_messages!
    return '' if resource.errors.empty?
    messages = resource.errors.full_messages.map { |msg| content_tag(:div,msg) }.join
    html = <<-HTML
    <div class="alert alert-danger alert-dismissable text-center">
     <button type="button" class="close" data-dismiss="alert">x</button>
      <strong>#{messages}</strong>
    </div>
    HTML
    html.html_safe
  end
end