class Contact < ApplicationRecord
  enum role: { child: 0, adult: 1, parentage: 2}

  validates :name, :email, :phone_number, :available_on, :role, presence: true

  scope :by_fuzzy_name, -> {  where("name LIKE ?", "%#{name}%").select(:name, :id, :email, :phone_number, :role, :available_on).limit(50) }

end
