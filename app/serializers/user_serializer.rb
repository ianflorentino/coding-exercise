class UserSerializer < ActiveModel::Serializer
  attributes :id,
             :uid,
             :name,
             :prynt_auth_token,
             :provider

  has_many :tasks
end
