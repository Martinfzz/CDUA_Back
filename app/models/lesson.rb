class Lesson
  include Mongoid::Document

  field :title, type: String
  field :content, type: String

  belongs_to :post
end
