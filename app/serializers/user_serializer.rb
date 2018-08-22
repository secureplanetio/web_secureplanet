class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :company, :role, :app_version, :use_ldap

  def company
    'Secure Planet'
  end

  def app_version
    ''
  end

  def use_ldap
    false
  end
end
