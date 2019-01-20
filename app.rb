require 'rubygems'
require 'bundler'

Bundler.require :default, ENV['RACK_ENV'] || :development

def recursive_require(file)
  File.directory?(file) ? Dir.glob(file + '/*').each(&method(:recursive_require)) : require(file)
end

Dir.glob(File.dirname(__FILE__) + '/lib/*').each(&method(:recursive_require))

class App < Sinatra::Base

  set :root, File.dirname(__FILE__)
  enable :logging

  register Web::App

  configure :development do
    register Sinatra::Reloader
  end
end