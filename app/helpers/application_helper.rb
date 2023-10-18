module ApplicationHelper
  include Pagy::Frontend

  ALERT_CSS = {
    'alert' => 'bg-red-100 text-red-700',
    'error' => 'bg-red-100 text-red-700',
    'success' => 'bg-green-100 text-green-700',
    'notice' => 'bg-blue-100 text-blue-700'
  }

  def alert_style(value)
    ALERT_CSS[value]
  end

   def qr_code_as_svg(uri)
    RQRCode::QRCode.new(uri).as_svg(
      offset: 0,
      color: '000',
      shape_rendering: 'crispEdges',
      module_size: 3,
      standalone: true
    ).html_safe
  end

  def extract_from_url(link)
    File.basename(link)
  end

end
