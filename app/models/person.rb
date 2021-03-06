class Person < ActiveRecord::Base
  include HTTParty

  format :xml
  basic_auth 'kscott', 'kds007'
  
  def self.persist(people)
    count = 0
    people.each do |p|
      unless Person.find_by_ccb_id(p.ccb_id)
        p.save
        count += 1
      end
    end
    count
  end

  def sync
    Person.default_params :srv => 'update_individual', :individual_id => ccb_id
    response = Person.post 'http://dev/api.php', :body => attributes
  end

  def insert
    Person.default_params :srv => 'create_individual'
    response = Person.post 'http://dev/api.php', :body => attributes
    p = response.parsed_response['ccb_api']['response']['individuals']['individual']
    self.ccb_id = p['id']
    self.save
  end
end
