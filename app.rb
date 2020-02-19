require_relative 'config/environment'
require_relative 'models/text_analyzer.rb'

class App < Sinatra::Base
  get '/' do
    erb :index
  end

  post '/' do
    @vowels = 0
    @consonants = 0
    @text_from_user = params[:user_text]
    @letter_hash = {}
    params[:user_text].split(' ').each do |word|
      word.chars.each_with_index do |char, index|
        if char.downcase=="a" || char.downcase=="e" || char.downcase=="i" || char.downcase=="o" || char.downcase=="u"
          @vowels += 1
        else
          @consonants += 1
        end

        if @letter_hash[char.downcase]
          @letter_hash[char.downcase] += 1
        else
          @letter_hash[char.downcase] = 1
        end

      end
    end
    @max_kv_pair = @letter_hash.max_by{|k,v| v} #returns array of [key, value]
    erb :results
  end
end

