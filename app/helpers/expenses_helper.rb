module ExpensesHelper
  def format_date(date)
    date.strftime("%d %B, %Y")
  end
end
