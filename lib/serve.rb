Dir.chdir(ROOT_PATH)

Bundler.require(:db, :serve)
require 'json'
require 'db'
require 'models'

INTERFACE = "0.0.0.0"
PORT = 8000

class Server < Roda
  opts[:root] = ROOT_PATH
  plugin :public, root: 'public'
  plugin :json, classes: [Array, Hash, Sequel::Model]

  route do |r|
    r.public

    r.root do
      r.redirect "index.html"
    end

    r.on "meter"do

        r.on Integer do |id|
          @meter = Meter[id]

          r.get "indices" do
            @meter.indices.collect {|i| [i.created_at.httpdate, i.value.truncate(3)]}
          end

          r.is do
            r.get do @meter end
          end
        end

        r.is do
          r.get do Meter.all end
        end
    end
  end
end

Rack::Handler::WEBrick.run Server.freeze.app, :Port => PORT, :Host => INTERFACE
