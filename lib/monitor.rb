Dir.chdir(ROOT_PATH)

Bundler.require(:db, :monitor)

require 'db'
require 'models'

cellule = Rpio::Gpio.new pin: 26, trigger: :falling

### Mesure de la Consommation
conso_meter = Meter[name: 'Consommation Enédis']

conso_buffer = CounterBuffer.new size: 4000, max_age: 5*60 do |c|
  report = conso_buffer.push content
end

conso_thread = cellule.watch do |gpio|
  conso_buffer.top
end

#### Mesure de la puissance instannée
power_meter = Meter[name: 'Puissance Enédis']

power_buffer = FrequencyBuffer.new size: 10, max_age: 2*60 do
  power_meter.push rph
end

power_thread = cellule.watch do |gpio|
  power_buffer.top
end

print " Waiting. from #{Time.now}.\n"
loop { sleep 1 }
