class User < ActiveRecord::Base
   has_many :projects
   has_many :contacts
   has_many :jobs
   has_many :comments
   has_many :histories
   has_many :works

   before_validation :password_validation
   validates_presence_of :login, :name
   validates_format_of :login, :with => /[-a-zA-Z0-9]+$/
   validates_length_of :login, :within => 3..40
   validates_length_of :name, :within => 3..40
   validates_uniqueness_of :login, :case_sensitive => false

   
   after_validation :crypt_password

   attr_accessor  :password_new, :password_new_comf, :role3,:role5,:role7,:role11,:role13

  def self.authenticate(login, password)
  	find_by_login_and_password(login, Digest::SHA1.hexdigest(password))
  end

  def worker?
      if( self.role % Role.find_by_name("WORKER").idd == 0)
        true
      else
        false
      end
  end

  def admin?
    if( self.role % Role.find_by_name("ADMIN").idd == 0)
        true
      else
        false
      end
  end

   def accountant?
      if( self.role % Role.find_by_name("ACCOUNTANT").idd == 0)
        true
      else
        false
      end
  end

  def produce?
      if( self.role % Role.find_by_name("PRODUCE").idd == 0)
        true
      else
        false
      end
  end

  def client?
      if( self.role % Role.find_by_name("CLIENT").idd == 0)
        true
      else
        false
      end
  end


  def mine?(item)
      if admin?
        true
      else
        item.user_id == self.id
      end
   end

  private



   def crypt_password
      if not password_new.blank?
       self.password = Digest::SHA1.hexdigest(password_new)
      end
   end


    def password_validation
      if password_new_comf.blank? && password_new.blank?

      else if ( password_new != password_new_comf)
          errors.add_to_base("zadaná hesla se nerovnají")
          false
        end
      end
    end
end

