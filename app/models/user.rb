class User
  include Mongoid::Document
  include RailsJwtAuth::Authenticatable
  # include RailsJwtAuth::Confirmable
  include RailsJwtAuth::Recoverable
  include RailsJwtAuth::Trackable
  include RailsJwtAuth::Invitable
  include RailsJwtAuth::Lockable

  field :email, type: String
  field :first_name, type: String
  field :last_name, type: String

  validates :email, presence: true,
                    uniqueness: true,
                    format: URI::MailTo::EMAIL_REGEXP

  has_many :lessons, dependent: :destroy
end
