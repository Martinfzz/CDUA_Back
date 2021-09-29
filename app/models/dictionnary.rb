class Dictionnary
  include Mongoid::Document

  field :title, type: String
  field :lang, type: String
  field :data, type: Array
end
