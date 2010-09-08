class Calendar
  include HTTParty
  
  format :xml
  basic_auth 'kscott', 'kds007'

  def self.pull
    default_params :srv => 'public_calendar_listing'
    response = get 'http://dev/api.php', :query => {:date_start => Time.now.strftime('%Y-%m-%d'), :date_end => (Time.now + 3.days).strftime('%Y-%m-%d')}
  end
end