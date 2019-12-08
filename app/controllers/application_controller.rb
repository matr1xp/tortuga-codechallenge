require 'shorturl_at'

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  $stop_words = Stopword.all.pluck(:word)
end
