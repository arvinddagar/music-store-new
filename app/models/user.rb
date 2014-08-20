class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,:confirmable, :registerable,
	         :recoverable, :rememberable, :trackable, :validatable,:omniauthable
  acts_as_messageable
  # ASSOCIATIONS
  has_one :student, dependent: :destroy
  has_one :tutor, dependent: :destroy
  after_create :save_student
  @@name = ""
  def type
    role.class.to_s.downcase.to_sym if role
  end

  def student?
    type == :student
  end

  def tutor?
    type == :tutor
  end
  def save_student
    split = @@name.split(' ', 2)
    @first_name = split.first
    @last_name = split.last
    if self.provider.present?
      Student.create(user_id: self.id , first_name: @first_name, last_name: @last_name)
    end
  end
  def role
    tutor || student
  end
 def self.from_omniauth(auth)
  where(auth.slice(:provider, :uid)).first_or_create do |user|
    user.email = auth.info.email
    user.password = Devise.friendly_token[0,20]
    user.skip_confirmation!
    @@name = auth.info.name
  end

end
def self.new_with_session(params, session)
  if session["devise.user_attributes"]
    new(session["devise.user_attributes"], without_protection: true) do |user|
      user.attributes = params
      user.valid?
    end
  else
    super
  end
end
end
