#https://github.com/hgmnz/truncate_html
TruncateHtml.configure do |config|
  config.length        = 1000
  config.omission      = '...'
  config.break_token = '<!-- truncate -->'
end