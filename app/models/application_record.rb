class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.results(per_page, page_number)
    if page_number == 1
      limit(per_page)
    else
      limit(per_page).offset(per_page * (page_number - 1))
    end
  end
  
end
