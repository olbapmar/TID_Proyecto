#!/usr/bin/env ruby

# Execution: ./pdf.rb [name of the file to be parsed]
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
		month_i = month[0].to_i
		month_names[month_i - 1]
	end
	tipos = string_matrix.lines[2].scan(/(?<=\()[[:word:]]+(?=\))/u)
	
	(3..string_matrix.lines.size - 1).each do |line_number|
		line_tokens = string_matrix.lines[line_number].strip.split(/\s+/)
		hour = line_tokens[0]
	end
end

matrix_regex = /(?<=Carril\/es:).*?(?=Total)/m
ARGV.each do |arg|
	matrix = PDF::Reader.open(arg) do |reader|
		txt = reader.pages[0].text
		matrix = matrix_regex.match(txt).to_s.gsub(/^\s*$\n?/,'')
	end
	parse_matrix(matrix)
end