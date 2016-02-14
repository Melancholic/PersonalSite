class User < ActiveRecord::Base
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable, :omniauthable,  :confirmable
    has_many :identities, dependent: :destroy
    has_many :articles
    TEMP_EMAIL_PREFIX = 'change@me'
    TEMP_EMAIL_REGEX = /\Achange@me/

    validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update
    has_and_belongs_to_many :roles

    after_create do |user|
      user.make_as!(:member)
    end

    def get_name
      self.email.split('@').first
      self.name if self.name.present?
    end

    def self.find_for_oauth(auth, signed_in_resource = nil)
        # Get the identity and user if they exist
        identity = Identity.find_for_oauth(auth)

        # If a signed_in_resource is provided it always overrides the existing user
        # to prevent the identity being locked with accidentally created accounts.
        # Note that this may leave zombie accounts (with no associated identity) which
        # can be cleaned up at a later date.
        user = signed_in_resource ? signed_in_resource : identity.user

        # Get the existing user by email if the provider gives us a verified email.
        # If no verified email was provided we assign a temporary email and ask the
        # user to verify it on the next step via UsersController.finish_signup
        email_is_verified = auth.info.email #&& (auth.info.verified || auth.info.verified_email)
        email = auth.info.email if email_is_verified
        
        # Create the user if needed
        if user.nil?

          user = User.where(:email => email).first if email

          # Create the user if it's a new registration
          if user.nil?
            user = User.new(
              name: auth.extra.raw_info.name,
              email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
              password: Devise.friendly_token[0,20]
              )
            user.skip_confirmation!
            user.save!
          end
        else
          unless(user.email_verified?)
            user.email= email if email
            user.skip_reconfirmation!
            user.save!
          end
        end
        # Associate the identity with the user if needed
        if identity.user != user
          identity.user = user
          identity.save!
        end
        user
      end

      def email_verified?
        self.email && self.email !~ TEMP_EMAIL_REGEX
      end

      def role?(role)
        if (self.new_record?) 
          role.to_s==Role.find_by_name('guest').try(:name) 
        else
          !!self.roles.find_by_name(role.to_s.downcase)
        end
      end

      def make_as!(role)
        raise ArgumentError.new("Only roles are allowed: #{Role.names}") unless( Role.names.include?(role.to_s))
        if (role == :administrator)
          self.roles=[Role.find_by_name(role)]
        elsif (role == :moderator)
          self.roles= [Role.find_by_name(role), Role.find_by_name('member')]
        elsif (role == :author)
          self.roles= [Role.find_by_name(role), Role.find_by_name('member')]
        elsif (role == :member)
          self.roles= [Role.find_by_name('member')]
        elsif (role == :banned)
          self.roles=  [Role.find_by_name('banned')]
        end  
        self.save!
      end
    end
