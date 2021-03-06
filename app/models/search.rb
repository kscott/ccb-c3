class Search < ActiveRecord::Base
  include HTTParty

  format :xml
  basic_auth 'kscott', 'kds007'

  def self.import_ccb
    default_params :srv => 'search_list'
    response = get 'http://dev/api.php'
    count = 0

    unless response.parsed_response['ccb_api']['response']['searches']['search'].nil?
      response.parsed_response['ccb_api']['response']['searches']['search'].each do |search|
        unless Search.find_by_name(search['name'])
          Search.create :ccb_id => search['id'], :name => search['name']
          count += 1
        end 
      end
    end
    count
  end

  def matches
    Search.default_params :srv => 'execute_search'
    response = Search.get 'http://dev/api.php', :query => { :id => ccb_id }
    
    people = []
    unless response.parsed_response['ccb_api']['response']['individuals']['individual'].nil?
      response.parsed_response['ccb_api']['response']['individuals']['individual'].each do |person|
        #logger.debug(person.keys)
        p = Person.new :ccb_id => person['id'], :first_name => person['first_name'], :last_name => person['last_name'], :email => person['email']
        people << p
      end
    end
    people
  end
end
