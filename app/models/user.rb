class User
  include Mongoid::Document
  include Mongoid::Timestamps
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:weibo]

  ## Database authenticatable
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  ## Confirmable
  # field :confirmation_token,   type: String
  # field :confirmed_at,         type: Time
  # field :confirmation_sent_at, type: Time
  # field :unconfirmed_email,    type: String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  # field :locked_at,       type: Time

  field :name,       type: String
  field :avatar_url, type: String

  has_many :user_tokens
  has_many :folders

  # https://github.com/mongoid/mongoid/issues/3626#issuecomment-64700154
  def self.serialize_from_session(key, salt)
    (key = key.first) if key.kind_of? Array
    (key = BSON::ObjectId.from_string(key['$oid'])) if key.kind_of? Hash

    record = to_adapter.get(key)
    record if record && record.authenticatable_salt == salt
  end

  def self.serialize_into_session(record)
    [record.id.to_s, record.authenticatable_salt]
  end

  def apply_omniauth(omniauth)
    if omniauth['credentials'].blank?
      user_tokens.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
    else
      user_tokens.build(:provider => omniauth['provider'],
                        :uid => omniauth['uid'],
                        :token => omniauth['credentials']['token'],
                        :expires_at => omniauth['credentials']['expires_at'])
    end
  end

  def password_required?
    false
  end

  def email_required?
    false
  end

  def self.from_weibo_omniauth(auth_hash)
    omniauth_info = self._get_info_form_weibo_omniauth(auth_hash)
    self.from_omniauth_info(omniauth_info)
  end

  def self.from_omniauth_info(omniauth_info)
    uid        = omniauth_info[:uid]
    provider   = omniauth_info[:provider]
    token      = omniauth_info[:token]
    expires_at = omniauth_info[:expires_at]
    expires    = omniauth_info[:expires]
    avatar_url = omniauth_info[:avatar_url]
    user_name  = omniauth_info[:user_name]

    # 若不存在对应的 user_token 则创建
    # 若存在则更新
    user_token = UserToken.where(
      :uid      => uid,
      :provider => provider
    ).first_or_initialize

    user_token.update_attributes(
      :token      => token,
      :expires_at => expires_at,
      :expires    => expires
    )

    # 若不存在对应的 user 则创建
    # 若存在则更新
    user = user_token.user ||
      User.create!(
        :name => user_name,
        :user_tokens => [user_token],
        :password => Devise.friendly_token.first(8)
      )

    user.update_attributes(
      :name => user_name,
      :avatar_url => avatar_url
    )

    return user
  end

  def self._get_info_form_weibo_omniauth(auth_hash)
    {
      uid:        auth_hash.uid,
      provider:   auth_hash.provider,
      token:      auth_hash.credentials.token,
      expires_at: auth_hash.credentials.expires_at,
      expires:    auth_hash.credentials.expires,
      avatar_url: auth_hash.extra.raw_info.avatar_large,
      user_name:  auth_hash.info.nickname
    }
  end
end
