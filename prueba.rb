#!/usr/bin/env ruby

require 'net/http'
require 'json'
require 'openssl'

key = File.read("resources/api_aemet")

if(key.nil? || key == "")
    puts "No está la key de la api del tiempo" 
    exit 1
end

url_s = "https://opendata.aemet.es/opendata/api/valores/climatologicos/diarios/datos/fechaini/2016-07-01T00%3A00%3A00UTC/fechafin/2016-08-01T00%3A00%3A00UTC/estacion/C447A?api_key=#{key}"
url = URI(url_s)

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE
response = http.get(url)

url_datos = URI(JSON.parse(response.body)['datos'])

response = http.get(url_datos).body