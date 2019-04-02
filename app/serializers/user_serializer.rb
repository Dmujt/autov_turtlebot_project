class UserSerializer < ActiveModel::Serializer
    attributes :id, :email, :fname, :lname
  
  end