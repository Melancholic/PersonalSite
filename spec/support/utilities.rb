include ApplicationHelper
include StaticPagesHelper
#Capybara
## USE: find(:linkhref, <path>).click 
module Selectors
  Capybara.add_selector(:linkhref) do
    xpath {|href| ".//a[@href='#{href}']"}
  end
end
