class SignupSerializer < ActiveModel::Serializer
  attributes :id, :time
  has_one :activity
  has_one :camper
end
