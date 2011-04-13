class CalWidget < Widget
  def self.title
    "Calendar"
  end
  
  def self.view
    "widgets/calendar"
  end
  
  def username= user
    
  end
  
  def username
    
  end
  
  def password= pass
    
  end
  
  def password
    
  end
  
  def available_settings
    [:username, :password]
  end
end