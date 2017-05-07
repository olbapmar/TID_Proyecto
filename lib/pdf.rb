require 'pdf/reader' # gem install pdf-reader
require_relative 'dato'
require_relative './lluvia'

def parse_matrix(string_matrix)
	datos = []

	month_names = [
		"Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio",
		"Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"]

	week_days = string_matrix
				.lines
				.first
				.strip
				.split(/\s+/)
	week_days.pop
	days = string_matrix.lines[1].scan(/.*?(\d{2}\/\d{2}\/\d{4})/)
	rain = get_rain(days[0].to_s, days[6].to_s)
	months = string_matrix.lines[1].scan(/(?:.*?\/)(\d{2})(?:\/)/).map do |month|
		month_i = month[0].to_i
		month_names[month_i - 1]
	end

	string_matrix = /Hora.*/m.match(string_matrix).to_s

	tipos = string_matrix.lines[0].scan(/(?<=\()[[:word:]]+(?=\))/u)

	(1..24).each do |line_number|
		line_tokens = string_matrix.lines[line_number].strip.split(/\s+/)
		hour = line_tokens[0].scan(/\d+(?=:)/)[0].to_i
		(1..7).each do |i|
			datos.push(Dato.new(week_days[i - 1], months[i - 1], hour, tipos[i - 1], line_tokens[i].gsub(/\./,'').to_i, rain[i -1]))
		end
	end
	datos
end

def analyze_pdf(names)
	datos = []
	matrix_regex = /(Lunes|Martes|Miércoles|Jueves|Viernes|Sábado|Domingo).*?(?=Total)/m
	contador = 0
	names.each do |arg|
		puts arg
		matrix = PDF::Reader.open(arg) do |reader|
			txt = reader.pages[0].text
			matrix = matrix_regex.match(txt).to_s.gsub(/^\s*$\n?/,'')
			matrix
		end
		datos.concat(parse_matrix(matrix))
		contador = contador + 1
	end
	datos
end
