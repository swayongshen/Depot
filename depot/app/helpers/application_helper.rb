module ApplicationHelper
  def hidden_div_if(condition, attributes = {}, &block)
    if condition
      attributes["style"] = "display: none"
    end
    content_tag("div", attributes, &block)
  end

  # Converts dd/mm/yyyy HH:MM local time string to DateTime object in UTC
  def parse_user_date_time(user_input)
    date_time_format = "%d/%m/%Y %H:%M"
    DateTime.strptime(user_input, date_time_format)
  end
end
