module ApplicationHelper
  def friendly_date(date)
    date.strftime("%b %d, %Y")
  end
end
