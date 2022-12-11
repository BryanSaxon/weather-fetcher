module ApplicationHelper
  def weather_icon(icon)
    image_tag "weather-icons/#{icon}.png", class: "weather-icon"
  end

  def boolean_display(boolean)
    if boolean
      content_tag :span, "Yes", class: "inline-flex items-center rounded-full bg-green-600 px-3 py-0.5 text-sm font-medium text-white"
    else
      content_tag :span, "No", class: "inline-flex items-center rounded-full bg-red-600 px-3 py-0.5 text-sm font-medium text-white"
    end
  end
end
