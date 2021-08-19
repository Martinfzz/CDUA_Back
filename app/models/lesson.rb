class Lesson
  include Mongoid::Document

  field :title, type: String
  field :content, type: String

  validates :title, presence: true, length: {minimum: 1, maximum: 100}

  belongs_to :post
end
