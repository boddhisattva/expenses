module ExpensesHelper
  def format_date(date)
    date.strftime("%d %B, %Y")
  end

  def display_ajax_failure(message)
    html = ""
    html << "<div class='alert alert-danger '>\n"
    html << "<a href='#' class='close' onClick=\"parentNode.remove()\">×</a>"
    html << "#{message}"
    html << "</div>\n"
    html
  end

  def display_ajax_success(message)
    html = ""
    html << "<div class='alert alert-success '>\n"
    html << "<a href='#' class='close' onClick=\"parentNode.remove()\">×</a>"
    html << "#{message}"
    html << "</div>\n"
    html
  end
end
