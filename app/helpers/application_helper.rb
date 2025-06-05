# frozen_string_literal: true

module ApplicationHelper
  def safe_external_url(url)
    uri = URI.parse(url)
    if uri.is_a?(URI::HTTP) || uri.is_a?(URI::HTTPS)
      url
    else
      '#'
    end
  rescue URI::InvalidURIError
    '#'
  end
end
