module Web
  module App
    def self.registered(app)
      app.get '/' do
        Web::Actions::Root.call(request)
      end
    end
  end
end
