require 'telegram/bot'
require 'date'

token = '362555664:AAG2ijCDTbC_dY6dVhOGbq2DmBBFfqAzhJU'

semana = ['Domingo', 'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sabado']
mes = ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio",
  "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"]



  def calcular_lluvia()

    url = URI("https://opendata.aemet.es/opendata/api/prediccion/especifica/municipio/diaria/38023/?api_key=eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhbHUwMTAwODkwODM5QHVsbC5lZHUuZXMiLCJqdGkiOiIwNDNkMGU0YS1jZmY0LTQzOTItYTVhMS0wZDg2YmM3MWRmMGEiLCJleHAiOjE0OTg3NTE1NjgsImlzcyI6IkFFTUVUIiwiaWF0IjoxNDkwOTc1NTY4LCJ1c2VySWQiOiIwNDNkMGU0YS1jZmY0LTQzOTItYTVhMS0wZDg2YmM3MWRmMGEiLCJyb2xlIjoiIn0.--lwzjwDhL5Wq8LBO2XUWbH7NAXwvkUqDJ_Tas6-kqY")
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
      dataPrecipitacion = JSON response.read_body
    end

    if (dataPrecipitacion[0]["prediccion"]["dia"][0]["probPrecipitacion"][0]["value"].to_i >= 50)
      return 'si'
    end

    return 'no'

  end



Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    date = Time.at(message.date)
    begin
      lluvia = calcular_lluvia()
    rescue
      lluvia = no
      puts "Está petando."
    end
    case message.text
    when '/festivo'
      respuesta = `java -cp weka.jar:. Main #{semana[date.wday]} #{mes[date.month - 1]} #{date.hour} Festivo #{lluvia}`
      bot.api.send_message(chat_id: message.chat.id, text: "¡Hola #{message.from.first_name}! La predicción para hoy en Anchieta es: #{respuesta}")
    when '/laboral'
        respuesta = `java -cp weka.jar:. Main #{semana[date.wday]} #{mes[date.month - 1]} #{date.hour} Laboral #{lluvia}`
      bot.api.send_message(chat_id: message.chat.id, text: "¡Hola #{message.from.first_name}! La predicción para hoy en Anchieta es: #{respuesta}")
    when '/vispera'
      respuesta = `java -cp weka.jar:. Main #{semana[date.wday]} #{mes[date.month - 1]} #{date.hour} Víspera #{lluvia}`
      bot.api.send_message(chat_id: message.chat.id, text: "¡Hola #{message.from.first_name}! La predicción para hoy en Anchieta es: #{respuesta}")
    when '/stop'
      bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}")
    end
  end
end
