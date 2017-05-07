require 'uri'
require 'net/http'
require 'openssl'
require 'json'


def get_rain(date1, date2)

  date1 = date1.scan(/(\d{2})\/(\d{2})\/(\d{4})/)[0]
  date2 = date2.scan(/(\d{2})\/(\d{2})\/(\d{4})/)[0]

  puts "#{date1[0]}-#{date1[1]}-#{date1[2]}"
  outputArray = []
  no_error = true;
  while (no_error)

    no_error = false

    url = URI("https://opendata.aemet.es/opendata/api/valores/climatologicos/diarios/datos/fechaini/"+ date1[2] + "-" + date1[1] +
    "-" + date1[0] + "T00%3A00%3A00UTC/fechafin/" + date2[2] + "-" + date2[1] + "-" + date2[0] + "T00%3A00%3A00UTC/estacion/C447A/?api_key=eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhbHUwMTAwODQxNTY1QHVsbC5lZHUuZXMiLCJqdGkiOiJmYWI0ODg3NS03OTZkLTQyNjQtOTQyNC0wYjA5YzkxMDY3YmQiLCJleHAiOjE0OTk3OTYyNTksImlzcyI6IkFFTUVUIiwiaWF0IjoxNDkyMDIwMjU5LCJ1c2VySWQiOiJmYWI0ODg3NS03OTZkLTQyNjQtOTQyNC0wYjA5YzkxMDY3YmQiLCJyb2xlIjoiIn0.DaGuQApC8Td-r2AmWWO82_3TWZa_DxZWMrRtHvFmcpk")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(url)
    request["cache-control"] = 'no-cache'
    response = http.request(request)
    data = JSON response.read_body
    if (data["descripcion"] == "exito")
      url = URI(data["datos"])
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      request = Net::HTTP::Get.new(url)
      request["cache-control"] = 'no-cache'
      response = http.request(request)
      dataEstacion = JSON response.read_body

      (0..(dataEstacion.size - 1)).each do |i|
        if (dataEstacion[i]["prec"].sub(',', '.').to_f < 48.0)
          outputArray << "no"
        else
          outputArray << "si"
        end
      end
    else
      puts "Too many requests. Trying again"
      sleep(7)
      no_error = true
    end

  end
  outputArray

end

#get_rain("22/04/2016", "23/04/2016")
