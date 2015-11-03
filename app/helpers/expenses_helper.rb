module ExpensesHelper
  def format_date(date)
    date.strftime("%d %B, %Y")
  end

  def display_alert_message(message, alert_class)
    html = ""
    html << "<div class='alert alert-#{alert_class} '>\n"
    html << "<a href='#' class='close' onClick=\"parentNode.remove()\">×</a>"
    html << "#{message}"
    html << "</div>\n"
    html.html_safe
  end
end
