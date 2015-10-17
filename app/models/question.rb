class Question < ActiveRecord::Base
  require 'octokit'
  require 'base64'

  belongs_to :user, class_name: "::User", foreign_key: :user_id
  belongs_to :repo_tag, class_name: "::Repository", foreign_key: :repository_id
  has_many :answers, class_name: "::Answer"

  has_many :comments, as: :entity, class_name: "::Comment"
  has_many :votes, as: :entity, class_name: "::Vote"
  has_many :tag_users, class_name: "::TagUser"
  has_one :asked_to_answer, class_name: "::AskedToAnswer"

  # searchable do
  #   text :title
  #   integer :repository_id
  #   integer :user_id
  #   string :sort_title do
  #     title.downcase.gsub(/^(an?|the)/, '')
  #   end
  # end

  def self.search_title(params)
    query = params[:string]
    Question.search{fulltext query}.results[0...5]
  end

  def fetch_file_from_git_hub(uri)

    line_number = uri.split('#L')[1]

    parts = uri.split('#L')[0].split('/')
    for part in parts
      puts part
    end
    repo = parts[3] + "/" + parts[4]

    path = ""

    for i in 7..path.length
      path = path + "/" + part[i]
    end

    path.chomp('?') 

    line_number = 23
    #have to add token
    client = Octokit::Client.new(:access_token => "add token here")
    api_response = client.contents 'loconsolutions/housing-rails', :path => 'private/area_codes.csv', :branch => parts[6]
    text_contents = Base64.decode64( api_response.content )
    
    text_contents = text_contents.split("\n")



    result_lines = []

    count = 0
    for line in text_contents
      count = count+1
      if(count >= line_number - 2 && count <= line_number+5)
        result_lines.append(line)
      end
    end
    result_lines
  end


end
