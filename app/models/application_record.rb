class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.results(per_page, page_number)
    if page_number == 1
      limit(per_page)
    else
      limit(per_page).offset(per_page * (page_number - 1))
    end
  end

  def self.find_one(name)
    raise ActionController::BadRequest if name.blank?
    
    where('name ILIKE ?', "%#{name}%")
      .order(:name)
      .limit(1)
    
    # raise ActiveRecord::RecordNotFound
  end

  def self.find_all(name)
    where('name ILIKE ?', "%#{name}%")
      .order(:name)
  end
end
