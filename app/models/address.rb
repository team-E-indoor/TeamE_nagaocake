class Address < ApplicationRecord
  def post_code_and_address_and_name
    "〒#{self.post_code} #{self.address}\n#{self.name}"
  end

end
