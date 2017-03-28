#!/usr/bin/env ruby
require 'pdf/reader' # gem install pdf-reader

def parse_matrix(string_matrix)
	month_names = [
		"Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio",
		"Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"]
		
	week_days = string_matrix
				.lines
				.first
				.strip
				.split(/\s+/)
	week_days.pop
	
	months = string_matrix.lines[1].scan(/(?:.*?\/)(\d{2})(?:\/)/).map do |month|
		month_i = Integer(month[0])
		month_names[month_i - 1]
	end
	
	tipos = string_matrix.lines[2].scan(/(?<=\()[[:word:]]+(?=\))/u)
	
	(3..string_matrix.lines.size - 1).each do |line_number|
		puts string_matrix.lines[line_number].strip
	end
end

matrix_regex = /(?<=Carril\/es:).*?(?=Total)/m
matrix =

PDF::Reader.open(ARGV[0]) do |reader|
	txt = reader.pages[0].text
	matrix = matrix_regex.match(txt).to_s.gsub(/^\s*$\n?/,'')
end

parse_matrix(matrix)