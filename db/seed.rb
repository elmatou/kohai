id = DB[:meters].insert(name: 'Enédis', multiplier: 2.5/1000, unit: 'kW.h', totalizer: true)
DB[:indices].insert(meter_id: id, value: 98402.000, created_at: '2019-06-11 16:18:00')
DB[:indices].insert(meter_id: id, value: 98562.555, created_at: '2019-06-19 13:19:00')

id = DB[:meters].insert(name: 'Grdf', multiplier: 1, unit: 'm3', totalizer: true')
DB[:indices].insert(meter_id: id, value: 20720.636, created_at: '2019-06-20 08:50:00')


DB[:meters].insert(name: 'Puissance Enédis', multiplier: 2.5, unit: 'W')


id = DB[:devices].insert(name: 'TCRT5000', object_type: 'Rpio::Gpio', object_options: {pin: 26, trigger: :falling} )
# DB[:meters].insert(name: 'Température Extérieur', multiplier: 1, unit: '°C', source: 'RTL::SDR')
# DB[:meters].insert(name: 'Température Intérieur', multiplier: 1, unit: '°C', source: 'RTL::SDR')
# DB[:meters].insert(name: 'Index UV', multiplier: 1, unit: '°C', source: 'OpenWeatherMap')
# DB[:meters].insert(name: 'Préssion atmosphérique', multiplier: 1, unit: 'hPa', source: 'I2C')

# DB[:devices].insert(class_name: Rpio::Gpio, create_options: {pin: 26, trigger: :falling})
# DB[:devices].insert(class_name: RtlSdr::RTL433, create_options: {pin: 26, trigger: :falling})
