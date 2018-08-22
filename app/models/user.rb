class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  after_create :create_profile

  has_one :profile, dependent: :destroy
  enum role: { user: 0, admin: 1, super_user: 2 }

  delegate :name, to: :profile

  scope :ordered_by_id, -> { order(id: :desc) }
  scope :detail, -> { joins('LEFT OUTER JOIN profiles on profiles.user_id = users.id')
                          .select('users.*', 'profiles.name as profile_name') }
  scope :admin_and_user, -> { where.not(role: roles[:super_user]).where(is_deleted: false) }
  scope :join_profile, -> { joins('LEFT OUTER JOIN profiles on profiles.user_id = users.id') }
  scope :active, -> { where(is_deleted: false) }
end
