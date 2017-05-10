require 'telegram/bot'
require 'date'

token = '362555664:AAG2ijCDTbC_dY6dVhOGbq2DmBBFfqAzhJU'

semana = ['Domingo', 'Lunes', 'Martes', 'Miercoles', 'Jueves', 'Viernes', 'Sabado']
mes = ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio",
  "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"]


Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    case message.text
    when '/start'
      date = Time.at(message.date)
      bot.api.send_message(chat_id: message.chat.id, text: "Payaso, #{message.from.first_name} #{semana[date.wday]}")
    when '/stop'
      bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}")
    end
  end
end
