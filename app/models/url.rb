class Url < ActiveRecord::Base
  belongs_to :user
  before_save :hash

  validates :origin, presence: true
  validates_format_of :origin, :multiline => true, :with => /^[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}$/
  validates :shorted, uniqueness: { scope: :user }

  BASE_URL = 'ly.com/'

  def self.base_url
    BASE_URL
  end

  def shorted
    "#{BASE_URL}#{hash}"
  end

  def hash
    shorted = Digest::MD5.hexdigest(origin).slice(0..6)
  end
end
